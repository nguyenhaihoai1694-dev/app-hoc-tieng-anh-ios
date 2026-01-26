import Foundation
import FirebaseFirestore
import Combine

class FirestoreService {
    static let shared = FirestoreService()
    private let db = Firestore.firestore()

    private init() {}

    // MARK: - User Management

    func createUser(_ user: User) async throws {
        let userData: [String: Any] = [
            "id": user.id.uuidString,
            "email": user.email,
            "name": user.name,
            "totalXP": user.totalXP,
            "level": user.level,
            "currentStreak": user.currentStreak,
            "longestStreak": user.longestStreak,
            "lastActiveDate": Timestamp(date: user.lastActiveDate),
            "joinedDate": Timestamp(date: user.joinedDate),
            "completedLessons": user.completedLessons,
            "createdAt": FieldValue.serverTimestamp()
        ]

        try await db.collection("users").document(user.id.uuidString).setData(userData)
    }

    func getUser(userId: String) async throws -> User? {
        let document = try await db.collection("users").document(userId).getDocument()

        guard document.exists,
              let data = document.data() else {
            return nil
        }

        return parseUserFromFirestore(data)
    }

    func updateUser(_ user: User) async throws {
        let userData: [String: Any] = [
            "name": user.name,
            "totalXP": user.totalXP,
            "level": user.level,
            "currentStreak": user.currentStreak,
            "longestStreak": user.longestStreak,
            "lastActiveDate": Timestamp(date: user.lastActiveDate),
            "completedLessons": user.completedLessons,
            "updatedAt": FieldValue.serverTimestamp()
        ]

        try await db.collection("users").document(user.id.uuidString).updateData(userData)
    }

    func updateUserXP(userId: String, xpToAdd: Int) async throws {
        let userRef = db.collection("users").document(userId)

        try await userRef.updateData([
            "totalXP": FieldValue.increment(Int64(xpToAdd)),
            "updatedAt": FieldValue.serverTimestamp()
        ])
    }

    func updateUserStreak(userId: String, streak: Int) async throws {
        try await db.collection("users").document(userId).updateData([
            "currentStreak": streak,
            "lastActiveDate": FieldValue.serverTimestamp()
        ])
    }

    // MARK: - Progress Management

    func saveLessonProgress(userId: String, lessonId: String, score: Int, xpEarned: Int) async throws {
        let progressData: [String: Any] = [
            "userId": userId,
            "lessonId": lessonId,
            "score": score,
            "xpEarned": xpEarned,
            "completedAt": FieldValue.serverTimestamp()
        ]

        let progressId = "\(userId)_\(lessonId)"
        try await db.collection("progress").document(progressId).setData(progressData, merge: true)
    }

    func getLessonProgress(userId: String, lessonId: String) async throws -> [String: Any]? {
        let progressId = "\(userId)_\(lessonId)"
        let document = try await db.collection("progress").document(progressId).getDocument()

        guard document.exists else { return nil }
        return document.data()
    }

    func getUserProgress(userId: String) async throws -> [[String: Any]] {
        let snapshot = try await db.collection("progress")
            .whereField("userId", isEqualTo: userId)
            .getDocuments()

        return snapshot.documents.map { $0.data() }
    }

    // MARK: - Leaderboard

    func getLeaderboard(limit: Int = 50) async throws -> [LeaderboardUser] {
        let snapshot = try await db.collection("users")
            .order(by: "totalXP", descending: true)
            .limit(to: limit)
            .getDocuments()

        return snapshot.documents.compactMap { doc -> LeaderboardUser? in
            guard let data = doc.data() as? [String: Any],
                  let name = data["name"] as? String,
                  let totalXP = data["totalXP"] as? Int,
                  let level = data["level"] as? Int else {
                return nil
            }

            return LeaderboardUser(
                id: doc.documentID,
                name: name,
                totalXP: totalXP,
                level: level
            )
        }
    }

    func getUserRank(userId: String) async throws -> Int? {
        let userDoc = try await db.collection("users").document(userId).getDocument()
        guard let userData = userDoc.data(),
              let userXP = userData["totalXP"] as? Int else {
            return nil
        }

        let snapshot = try await db.collection("users")
            .whereField("totalXP", isGreaterThan: userXP)
            .getDocuments()

        return snapshot.documents.count + 1
    }

    // MARK: - Realtime Listeners

    func listenToLeaderboard(limit: Int = 50, completion: @escaping ([LeaderboardUser]) -> Void) -> ListenerRegistration {
        return db.collection("users")
            .order(by: "totalXP", descending: true)
            .limit(to: limit)
            .addSnapshotListener { snapshot, error in
                guard let documents = snapshot?.documents else {
                    completion([])
                    return
                }

                let users = documents.compactMap { doc -> LeaderboardUser? in
                    guard let data = doc.data() as? [String: Any],
                          let name = data["name"] as? String,
                          let totalXP = data["totalXP"] as? Int,
                          let level = data["level"] as? Int else {
                        return nil
                    }

                    return LeaderboardUser(
                        id: doc.documentID,
                        name: name,
                        totalXP: totalXP,
                        level: level
                    )
                }

                completion(users)
            }
    }

    func listenToUser(userId: String, completion: @escaping (User?) -> Void) -> ListenerRegistration {
        return db.collection("users").document(userId).addSnapshotListener { snapshot, error in
            guard let data = snapshot?.data() else {
                completion(nil)
                return
            }

            let user = self.parseUserFromFirestore(data)
            completion(user)
        }
    }

    // MARK: - Helper Methods

    private func parseUserFromFirestore(_ data: [String: Any]) -> User? {
        guard let idString = data["id"] as? String,
              let id = UUID(uuidString: idString),
              let email = data["email"] as? String,
              let name = data["name"] as? String else {
            return nil
        }

        let totalXP = data["totalXP"] as? Int ?? 0
        let level = data["level"] as? Int ?? 1
        let currentStreak = data["currentStreak"] as? Int ?? 0
        let longestStreak = data["longestStreak"] as? Int ?? 0
        let completedLessons = data["completedLessons"] as? [String] ?? []

        var user = User(email: email, name: name)
        user.id = id
        user.totalXP = totalXP
        user.level = level
        user.currentStreak = currentStreak
        user.longestStreak = longestStreak
        user.completedLessons = completedLessons

        if let lastActiveTimestamp = data["lastActiveDate"] as? Timestamp {
            user.lastActiveDate = lastActiveTimestamp.dateValue()
        }

        if let joinedTimestamp = data["joinedDate"] as? Timestamp {
            user.joinedDate = joinedTimestamp.dateValue()
        }

        return user
    }
}

// MARK: - LeaderboardUser Model

struct LeaderboardUser: Identifiable {
    let id: String
    let name: String
    let totalXP: Int
    let level: Int
}
