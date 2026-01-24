import Foundation
import Combine

class UserProgressManager: ObservableObject {
    @Published var completedLessons: Set<UUID> = []
    @Published var lessonScores: [UUID: Int] = [:]

    private let userDefaults = UserDefaults.standard
    private let completedKey = "completedLessons"
    private let scoresKey = "lessonScores"

    init() {
        loadProgress()
    }

    func completeLesson(_ lessonId: UUID, score: Int, xpReward: Int, authViewModel: AuthViewModel) {
        completedLessons.insert(lessonId)

        // Update best score
        if let currentBest = lessonScores[lessonId] {
            if score > currentBest {
                lessonScores[lessonId] = score
            }
        } else {
            lessonScores[lessonId] = score
        }

        // Update user stats
        guard var user = authViewModel.currentUser else { return }

        user.totalXP += xpReward

        // Level up logic
        while user.totalXP >= user.nextLevelXP {
            user.level += 1
        }

        // Update streak
        updateStreak(for: &user)

        authViewModel.updateUser(user)
        saveProgress()
    }

    func isLessonCompleted(_ lessonId: UUID) -> Bool {
        return completedLessons.contains(lessonId)
    }

    func getScore(for lessonId: UUID) -> Int? {
        return lessonScores[lessonId]
    }

    private func updateStreak(for user: inout User) {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())

        if let lastPractice = user.lastPracticeDate {
            let lastPracticeDay = calendar.startOfDay(for: lastPractice)
            let daysDifference = calendar.dateComponents([.day], from: lastPracticeDay, to: today).day ?? 0

            if daysDifference == 0 {
                // Same day, no change
                return
            } else if daysDifference == 1 {
                // Next day, increment streak
                user.currentStreak += 1
            } else {
                // Streak broken
                user.currentStreak = 1
            }
        } else {
            // First practice
            user.currentStreak = 1
        }

        user.lastPracticeDate = Date()

        if user.currentStreak > user.longestStreak {
            user.longestStreak = user.currentStreak
        }
    }

    private func saveProgress() {
        // Save completed lessons
        let completedArray = Array(completedLessons).map { $0.uuidString }
        userDefaults.set(completedArray, forKey: completedKey)

        // Save scores
        let scoresDict = lessonScores.mapKeys { $0.uuidString }
        if let encoded = try? JSONEncoder().encode(scoresDict) {
            userDefaults.set(encoded, forKey: scoresKey)
        }
    }

    private func loadProgress() {
        // Load completed lessons
        if let completedArray = userDefaults.array(forKey: completedKey) as? [String] {
            completedLessons = Set(completedArray.compactMap { UUID(uuidString: $0) })
        }

        // Load scores
        if let data = userDefaults.data(forKey: scoresKey),
           let scoresDict = try? JSONDecoder().decode([String: Int].self, from: data) {
            lessonScores = scoresDict.compactMapKeys { UUID(uuidString: $0) }
        }
    }
}

// Helper extensions
extension Dictionary {
    func mapKeys<T: Hashable>(_ transform: (Key) -> T) -> [T: Value] {
        var result: [T: Value] = [:]
        for (key, value) in self {
            result[transform(key)] = value
        }
        return result
    }

    func compactMapKeys<T: Hashable>(_ transform: (Key) -> T?) -> [T: Value] {
        var result: [T: Value] = [:]
        for (key, value) in self {
            if let newKey = transform(key) {
                result[newKey] = value
            }
        }
        return result
    }
}
