import Foundation

struct User: Codable, Identifiable {
    var id: String  // Changed from UUID to String to match Firebase UID
    var email: String
    var name: String
    var currentStreak: Int
    var longestStreak: Int
    var totalXP: Int
    var level: Int
    var lastPracticeDate: Date?
    var lastActiveDate: Date
    var joinedDate: Date
    var completedLessons: [String]
    var isPremium: Bool
    var subscriptionExpiryDate: Date?

    init(id: String = UUID().uuidString, email: String, name: String) {
        self.id = id
        self.email = email
        self.name = name
        self.currentStreak = 0
        self.longestStreak = 0
        self.totalXP = 0
        self.level = 1
        self.lastPracticeDate = nil
        self.lastActiveDate = Date()
        self.joinedDate = Date()
        self.completedLessons = []
        self.isPremium = false
        self.subscriptionExpiryDate = nil
    }

    var nextLevelXP: Int {
        return level * 100
    }

    var progressToNextLevel: Double {
        let currentLevelXP = (level - 1) * 100
        let xpInCurrentLevel = totalXP - currentLevelXP
        return Double(xpInCurrentLevel) / Double(nextLevelXP - currentLevelXP)
    }
}
