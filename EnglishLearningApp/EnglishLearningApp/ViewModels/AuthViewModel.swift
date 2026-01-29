import Foundation
import Combine
import FirebaseAuth
import FirebaseFirestore
import AuthenticationServices

class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var currentUser: User?
    @Published var errorMessage: String?
    @Published var isLoading = false

    private let firebaseAuthService = FirebaseAuthService()
    private let firestoreService = FirestoreService.shared
    private var cancellables = Set<AnyCancellable>()
    private var userListener: ListenerRegistration?

    // Apple Sign-in delegate
    lazy var appleSignInDelegate: AppleSignInDelegate = {
        AppleSignInDelegate(authViewModel: self)
    }()

    init() {
        observeAuthState()
        // Disabled auto sign-in for production testing
        // loadUserAutomatically()
    }

    deinit {
        userListener?.remove()
    }

    // MARK: - Observe Auth State
    private func observeAuthState() {
        firebaseAuthService.$isAuthenticated
            .sink { [weak self] isAuth in
                print("📡 [AuthViewModel] Auth state changed: isAuthenticated = \(isAuth)")
                self?.isAuthenticated = isAuth
                if isAuth {
                    print("👤 [AuthViewModel] User authenticated, loading user data...")
                    self?.loadCurrentUser()
                } else {
                    print("🚪 [AuthViewModel] User signed out")
                    self?.currentUser = nil
                    self?.userListener?.remove()
                }
            }
            .store(in: &cancellables)
    }

    // MARK: - Auto Load User (for demo mode)
    private func loadUserAutomatically() {
        Task {
            do {
                // Try to sign in anonymously for demo
                _ = try await firebaseAuthService.signInAnonymously()
            } catch {
                print("Auto sign-in failed: \(error.localizedDescription)")
            }
        }
    }

    // MARK: - Load Current User from Firestore
    private func loadCurrentUser() {
        guard let firebaseUser = firebaseAuthService.currentUser else { return }

        Task { @MainActor in
            do {
                // Try to get user from Firestore
                if let user = try await firestoreService.getUser(userId: firebaseUser.uid) {
                    self.currentUser = user
                    setupRealtimeListener(userId: firebaseUser.uid)
                } else {
                    // Create new user in Firestore
                    let newUser = User(
                        email: firebaseUser.email ?? "demo@example.com",
                        name: firebaseUser.displayName ?? "Học viên"
                    )
                    var userToSave = newUser
                    userToSave.id = UUID(uuidString: firebaseUser.uid) ?? newUser.id

                    try await firestoreService.createUser(userToSave)
                    self.currentUser = userToSave
                    setupRealtimeListener(userId: firebaseUser.uid)
                }
            } catch {
                self.errorMessage = "Lỗi tải dữ liệu: \(error.localizedDescription)"
            }
        }
    }

    // MARK: - Realtime User Listener
    private func setupRealtimeListener(userId: String) {
        userListener?.remove()
        userListener = firestoreService.listenToUser(userId: userId) { [weak self] user in
            if let user = user {
                DispatchQueue.main.async {
                    self?.currentUser = user
                }
            }
        }
    }

    // MARK: - Login
    func login(email: String, password: String) {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Vui lòng nhập email và mật khẩu"
            return
        }

        isLoading = true
        errorMessage = nil

        Task { @MainActor in
            do {
                _ = try await firebaseAuthService.signIn(email: email, password: password)
                isLoading = false
            } catch {
                errorMessage = handleAuthError(error)
                isLoading = false
            }
        }
    }

    // MARK: - Register
    func register(email: String, name: String, password: String) {
        guard !email.isEmpty, !name.isEmpty, !password.isEmpty else {
            errorMessage = "Vui lòng điền đầy đủ thông tin"
            return
        }

        guard password.count >= 6 else {
            errorMessage = "Mật khẩu phải có ít nhất 6 ký tự"
            return
        }

        isLoading = true
        errorMessage = nil

        Task { @MainActor in
            do {
                let firebaseUser = try await firebaseAuthService.signUp(
                    email: email,
                    password: password,
                    name: name
                )

                // Create user in Firestore
                var newUser = User(email: email, name: name)
                newUser.id = UUID(uuidString: firebaseUser.uid) ?? newUser.id
                try await firestoreService.createUser(newUser)

                isLoading = false
            } catch {
                errorMessage = handleAuthError(error)
                isLoading = false
            }
        }
    }

    // MARK: - Logout
    func logout() {
        do {
            try firebaseAuthService.signOut()
            currentUser = nil
            userListener?.remove()
        } catch {
            errorMessage = "Lỗi đăng xuất: \(error.localizedDescription)"
        }
    }

    // MARK: - Update User
    func updateUser(_ user: User) {
        Task { @MainActor in
            do {
                try await firestoreService.updateUser(user)
                currentUser = user
            } catch {
                errorMessage = "Lỗi cập nhật: \(error.localizedDescription)"
            }
        }
    }

    // MARK: - Password Reset
    func resetPassword(email: String) {
        guard !email.isEmpty else {
            errorMessage = "Vui lòng nhập email"
            return
        }

        isLoading = true

        Task { @MainActor in
            do {
                try await firebaseAuthService.resetPassword(email: email)
                errorMessage = nil
                isLoading = false
            } catch {
                errorMessage = handleAuthError(error)
                isLoading = false
            }
        }
    }

    // MARK: - Error Handling
    private func handleAuthError(_ error: Error) -> String {
        if let authError = error as? AuthErrorCode {
            switch authError.code {
            case .emailAlreadyInUse:
                return "Email đã được sử dụng"
            case .invalidEmail:
                return "Email không hợp lệ"
            case .weakPassword:
                return "Mật khẩu quá yếu"
            case .userNotFound:
                return "Không tìm thấy tài khoản"
            case .wrongPassword:
                return "Mật khẩu không đúng"
            case .networkError:
                return "Lỗi kết nối mạng"
            default:
                return "Lỗi: \(error.localizedDescription)"
            }
        }
        return "Lỗi: \(error.localizedDescription)"
    }

    // MARK: - Sign in with Apple
    func signInWithApple(credential: ASAuthorizationAppleIDCredential) {
        print("🍎 [AuthViewModel] Starting Apple Sign-in...")
        isLoading = true
        errorMessage = nil

        Task { @MainActor in
            do {
                let user = try await firebaseAuthService.signInWithApple(credential: credential)
                print("✅ [AuthViewModel] Apple Sign-in successful! User ID: \(user.uid)")
                print("🔄 [AuthViewModel] isAuthenticated: \(self.isAuthenticated)")
                isLoading = false
            } catch {
                print("❌ [AuthViewModel] Apple Sign-in failed: \(error.localizedDescription)")
                errorMessage = "Lỗi đăng nhập Apple: \(error.localizedDescription)"
                isLoading = false
            }
        }
    }

    // MARK: - Sign in with Google
    func signInWithGoogle(idToken: String, accessToken: String) {
        print("🔍 [AuthViewModel] Starting Google Sign-in...")
        isLoading = true
        errorMessage = nil

        Task { @MainActor in
            do {
                let user = try await firebaseAuthService.signInWithGoogle(idToken: idToken, accessToken: accessToken)
                print("✅ [AuthViewModel] Google Sign-in successful! User ID: \(user.uid)")
                print("🔄 [AuthViewModel] isAuthenticated: \(self.isAuthenticated)")
                isLoading = false
            } catch {
                print("❌ [AuthViewModel] Google Sign-in failed: \(error.localizedDescription)")
                errorMessage = "Lỗi đăng nhập Google: \(error.localizedDescription)"
                isLoading = false
            }
        }
    }
}

// MARK: - Apple Sign-in Delegate
class AppleSignInDelegate: NSObject, ASAuthorizationControllerDelegate {
    weak var authViewModel: AuthViewModel?

    init(authViewModel: AuthViewModel) {
        self.authViewModel = authViewModel
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else {
            return
        }

        authViewModel?.signInWithApple(credential: credential)
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        DispatchQueue.main.async {
            self.authViewModel?.errorMessage = "Lỗi đăng nhập Apple: \(error.localizedDescription)"
            self.authViewModel?.isLoading = false
        }
    }
}
