import Foundation
import Combine

// Mock Firebase Auth User
class MockFirebaseUser {
    let uid: String
    let email: String?
    let displayName: String?

    init(uid: String, email: String? = nil, displayName: String? = nil) {
        self.uid = uid
        self.email = email
        self.displayName = displayName
    }
}

// Mock Firebase Auth Service (Use only if Firebase SDK not installed)
class FirebaseAuthService: ObservableObject {
    @Published var currentUser: MockFirebaseUser?
    @Published var isAuthenticated = false

    init() {}

    func signUp(email: String, password: String, name: String) async throws -> MockFirebaseUser {
        let user = MockFirebaseUser(uid: UUID().uuidString, email: email, displayName: name)
        currentUser = user
        isAuthenticated = true
        return user
    }

    func signIn(email: String, password: String) async throws -> MockFirebaseUser {
        let user = MockFirebaseUser(uid: UUID().uuidString, email: email)
        currentUser = user
        isAuthenticated = true
        return user
    }

    func signOut() throws {
        currentUser = nil
        isAuthenticated = false
    }

    func resetPassword(email: String) async throws {
        // Mock implementation
    }

    func signInAnonymously() async throws -> MockFirebaseUser {
        let user = MockFirebaseUser(uid: UUID().uuidString, email: nil, displayName: "Guest")
        currentUser = user
        isAuthenticated = true
        return user
    }
}
