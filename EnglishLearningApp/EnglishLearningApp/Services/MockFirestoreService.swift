import Foundation

// Mock Firestore Listener
class ListenerRegistration {
    func remove() {
        // Mock implementation
    }
}

// Mock Firestore Service (Use only if Firebase SDK not installed)
class FirestoreService {
    static let shared = FirestoreService()

    private init() {}

    // MARK: - User Management
    func createUser(_ user: User) async throws {
        print("Mock: Created user \(user.name)")
    }

    func getUser(userId: String) async throws -> User? {
        print("Mock: Get user \(userId)")
        return nil
    }

    func updateUser(_ user: User) async throws {
        print("Mock: Updated user \(user.name)")
    }

    func updateUserXP(userId: String, xpToAdd: Int) async throws {
        print("Mock: Updated XP for user \(userId): +\(xpToAdd)")
    }

    func updateUserStreak(userId: String, streak: Int) async throws {
        print("Mock: Updated streak for user \(userId): \(streak)")
    }

    // MARK: - Progress Management
    func saveLessonProgress(userId: String, lessonId: String, score: Int, xpEarned: Int) async throws {
        print("Mock: Saved progress - lesson \(lessonId), score: \(score)")
    }

    func getLessonProgress(userId: String, lessonId: String) async throws -> [String: Any]? {
        print("Mock: Get lesson progress")
        return nil
    }

    func getUserProgress(userId: String) async throws -> [[String: Any]] {
        print("Mock: Get user progress")
        return []
    }

    // MARK: - Leaderboard
    func getLeaderboard(limit: Int = 50) async throws -> [LeaderboardUser] {
        // Return mock leaderboard data
        return [
            LeaderboardUser(id: "1", name: "Nguyễn Văn A", totalXP: 2500, level: 15),
            LeaderboardUser(id: "2", name: "Trần Thị B", totalXP: 2100, level: 13),
            LeaderboardUser(id: "3", name: "Lê Văn C", totalXP: 1800, level: 12),
            LeaderboardUser(id: "4", name: "Phạm Thị D", totalXP: 1500, level: 10),
            LeaderboardUser(id: "5", name: "Hoàng Văn E", totalXP: 1200, level: 9),
        ]
    }

    func getUserRank(userId: String) async throws -> Int? {
        return Int.random(in: 1...100)
    }

    // MARK: - Realtime Listeners
    func listenToLeaderboard(limit: Int = 50, completion: @escaping ([LeaderboardUser]) -> Void) -> ListenerRegistration {
        // Return mock data after a delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion([
                LeaderboardUser(id: "1", name: "Nguyễn Văn A", totalXP: 2500, level: 15),
                LeaderboardUser(id: "2", name: "Trần Thị B", totalXP: 2100, level: 13),
                LeaderboardUser(id: "3", name: "Lê Văn C", totalXP: 1800, level: 12),
            ])
        }
        return ListenerRegistration()
    }

    func listenToUser(userId: String, completion: @escaping (User?) -> Void) -> ListenerRegistration {
        // Mock implementation
        return ListenerRegistration()
    }
}
