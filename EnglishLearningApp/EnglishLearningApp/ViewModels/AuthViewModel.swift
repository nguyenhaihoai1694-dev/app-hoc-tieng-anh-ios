import Foundation
import Combine

class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var currentUser: User?
    @Published var errorMessage: String?
    @Published var isLoading = false

    private let userDefaults = UserDefaults.standard
    private let userKey = "currentUser"

    init() {
        loadUser()
    }

    // MARK: - Load User
    private func loadUser() {
        if let data = userDefaults.data(forKey: userKey),
           let user = try? JSONDecoder().decode(User.self, from: data) {
            currentUser = user
            isAuthenticated = true
        } else {
            // Auto-create demo user (skip login)
            let demoUser = User(email: "demo@example.com", name: "Học viên")
            currentUser = demoUser
            isAuthenticated = true
            saveUser()
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

        // Simulate login delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let user = User(email: email, name: self.extractName(from: email))
            self.currentUser = user
            self.isAuthenticated = true
            self.saveUser()
            self.isLoading = false
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

        // Simulate register delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let user = User(email: email, name: name)
            self.currentUser = user
            self.isAuthenticated = true
            self.saveUser()
            self.isLoading = false
        }
    }

    // MARK: - Logout
    func logout() {
        currentUser = nil
        isAuthenticated = false
        userDefaults.removeObject(forKey: userKey)
    }

    // MARK: - Update User
    func updateUser(_ user: User) {
        currentUser = user
        saveUser()
    }

    // MARK: - Password Reset
    func resetPassword(email: String) {
        guard !email.isEmpty else {
            errorMessage = "Vui lòng nhập email"
            return
        }

        isLoading = true

        // Simulate password reset delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.errorMessage = nil
            self.isLoading = false
        }
    }

    // MARK: - Helpers
    private func saveUser() {
        guard let user = currentUser else { return }
        if let encoded = try? JSONEncoder().encode(user) {
            userDefaults.set(encoded, forKey: userKey)
        }
    }

    private func extractName(from email: String) -> String {
        return email.components(separatedBy: "@").first?.capitalized ?? "User"
    }
}
