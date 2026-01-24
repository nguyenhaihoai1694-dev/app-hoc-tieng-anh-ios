import Foundation
import Combine

class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var currentUser: User?
    @Published var errorMessage: String?

    private let userDefaults = UserDefaults.standard
    private let userKey = "currentUser"

    init() {
        loadUser()
    }

    func login(email: String, password: String) {
        // Simulate login - In production, integrate with backend API
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Vui lòng nhập email và mật khẩu"
            return
        }

        // Create or load user
        let user = User(email: email, name: extractName(from: email))
        currentUser = user
        isAuthenticated = true
        saveUser()
        errorMessage = nil
    }

    func register(email: String, name: String, password: String) {
        guard !email.isEmpty, !name.isEmpty, !password.isEmpty else {
            errorMessage = "Vui lòng điền đầy đủ thông tin"
            return
        }

        let user = User(email: email, name: name)
        currentUser = user
        isAuthenticated = true
        saveUser()
        errorMessage = nil
    }

    func logout() {
        currentUser = nil
        isAuthenticated = false
        userDefaults.removeObject(forKey: userKey)
    }

    func updateUser(_ user: User) {
        currentUser = user
        saveUser()
    }

    private func saveUser() {
        guard let user = currentUser else { return }
        if let encoded = try? JSONEncoder().encode(user) {
            userDefaults.set(encoded, forKey: userKey)
        }
    }

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

    private func extractName(from email: String) -> String {
        return email.components(separatedBy: "@").first?.capitalized ?? "User"
    }
}
