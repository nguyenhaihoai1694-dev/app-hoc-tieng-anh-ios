import Foundation
import FirebaseAuth
import Combine

class FirebaseAuthService: ObservableObject {
    @Published var currentUser: FirebaseAuth.User?
    @Published var isAuthenticated = false

    private var authStateHandler: AuthStateDidChangeListenerHandle?

    init() {
        registerAuthStateHandler()
    }

    deinit {
        if let handler = authStateHandler {
            Auth.auth().removeStateDidChangeListener(handler)
        }
    }

    // MARK: - Auth State Listener
    private func registerAuthStateHandler() {
        authStateHandler = Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            self?.currentUser = user
            self?.isAuthenticated = user != nil
        }
    }

    // MARK: - Sign Up
    func signUp(email: String, password: String, name: String) async throws -> FirebaseAuth.User {
        let result = try await Auth.auth().createUser(withEmail: email, password: password)

        // Update display name
        let changeRequest = result.user.createProfileChangeRequest()
        changeRequest.displayName = name
        try await changeRequest.commitChanges()

        return result.user
    }

    // MARK: - Sign In
    func signIn(email: String, password: String) async throws -> FirebaseAuth.User {
        let result = try await Auth.auth().signIn(withEmail: email, password: password)
        return result.user
    }

    // MARK: - Sign Out
    func signOut() throws {
        try Auth.auth().signOut()
    }

    // MARK: - Password Reset
    func resetPassword(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }

    // MARK: - Anonymous Sign In (for demo/guest users)
    func signInAnonymously() async throws -> FirebaseAuth.User {
        let result = try await Auth.auth().signInAnonymously()
        return result.user
    }

    // MARK: - Delete Account
    func deleteAccount() async throws {
        guard let user = currentUser else {
            throw NSError(domain: "FirebaseAuthService", code: -1, userInfo: [NSLocalizedDescriptionKey: "No user logged in"])
        }
        try await user.delete()
    }
}
