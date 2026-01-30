import SwiftUI

/// Achievement types for gamification
struct Achievement: Identifiable, Codable {
    let id: String
    let title: String
    let description: String
    let emoji: String
    let category: AchievementCategory
    let requirement: Int
    var isUnlocked: Bool = false
    var unlockedDate: Date?
    var progress: Int = 0

    var progressPercentage: Double {
        return min(Double(progress) / Double(requirement), 1.0)
    }
}

enum AchievementCategory: String, Codable, CaseIterable {
    case lessons = "Bài học"
    case streak = "Streak"
    case xp = "Kinh nghiệm"
    case perfect = "Hoàn hảo"
    case special = "Đặc biệt"

    var color: Color {
        switch self {
        case .lessons: return .blue
        case .streak: return .orange
        case .xp: return .yellow
        case .perfect: return .purple
        case .special: return .pink
        }
    }

    var icon: String {
        switch self {
        case .lessons: return "book.fill"
        case .streak: return "flame.fill"
        case .xp: return "star.fill"
        case .perfect: return "crown.fill"
        case .special: return "sparkles"
        }
    }
}

// MARK: - Achievement Manager
class AchievementManager: ObservableObject {
    static let shared = AchievementManager()

    @Published var achievements: [Achievement] = []
    @Published var newlyUnlockedAchievements: [Achievement] = []

    private var currentUserId: String?

    private init() {
        loadAchievements()
    }

    /// Load achievements for a specific user
    func loadAchievementsForUser(userId: String) {
        // If user changed, reset achievements
        if currentUserId != userId {
            currentUserId = userId
            loadAchievements()
            loadProgress(for: userId)
        }
    }

    /// Reset achievements for current user
    func resetAchievements() {
        guard let userId = currentUserId else { return }

        // Clear achievements
        for index in achievements.indices {
            achievements[index].isUnlocked = false
            achievements[index].unlockedDate = nil
            achievements[index].progress = 0
        }

        // Clear from UserDefaults
        UserDefaults.standard.removeObject(forKey: "achievements_\(userId)")
    }

    private func loadAchievements() {
        // Reset to default achievements
        achievements = [
            // Lesson Achievements
            Achievement(
                id: "first_lesson",
                title: "Bước đầu tiên",
                description: "Hoàn thành bài học đầu tiên",
                emoji: "🎯",
                category: .lessons,
                requirement: 1
            ),
            Achievement(
                id: "5_lessons",
                title: "Học sinh chăm chỉ",
                description: "Hoàn thành 5 bài học",
                emoji: "📚",
                category: .lessons,
                requirement: 5
            ),
            Achievement(
                id: "10_lessons",
                title: "Người học giỏi",
                description: "Hoàn thành 10 bài học",
                emoji: "🎓",
                category: .lessons,
                requirement: 10
            ),
            Achievement(
                id: "20_lessons",
                title: "Học giả",
                description: "Hoàn thành 20 bài học",
                emoji: "👨‍🎓",
                category: .lessons,
                requirement: 20
            ),
            Achievement(
                id: "all_lessons",
                title: "Cao thủ tiếng Anh",
                description: "Hoàn thành tất cả 40 bài học",
                emoji: "🏆",
                category: .lessons,
                requirement: 40
            ),

            // Streak Achievements
            Achievement(
                id: "3_day_streak",
                title: "Kiên trì",
                description: "Học liên tục 3 ngày",
                emoji: "🔥",
                category: .streak,
                requirement: 3
            ),
            Achievement(
                id: "7_day_streak",
                title: "Tuần hoàn hảo",
                description: "Học liên tục 7 ngày",
                emoji: "💪",
                category: .streak,
                requirement: 7
            ),
            Achievement(
                id: "30_day_streak",
                title: "Siêu kiên trì",
                description: "Học liên tục 30 ngày",
                emoji: "🌟",
                category: .streak,
                requirement: 30
            ),
            Achievement(
                id: "100_day_streak",
                title: "Huyền thoại",
                description: "Học liên tục 100 ngày",
                emoji: "👑",
                category: .streak,
                requirement: 100
            ),

            // XP Achievements
            Achievement(
                id: "100_xp",
                title: "Tân binh",
                description: "Đạt 100 XP",
                emoji: "⭐",
                category: .xp,
                requirement: 100
            ),
            Achievement(
                id: "500_xp",
                title: "Chiến binh",
                description: "Đạt 500 XP",
                emoji: "💫",
                category: .xp,
                requirement: 500
            ),
            Achievement(
                id: "1000_xp",
                title: "Cao thủ",
                description: "Đạt 1,000 XP",
                emoji: "✨",
                category: .xp,
                requirement: 1000
            ),
            Achievement(
                id: "5000_xp",
                title: "Siêu sao",
                description: "Đạt 5,000 XP",
                emoji: "🌠",
                category: .xp,
                requirement: 5000
            ),

            // Perfect Score Achievements
            Achievement(
                id: "first_perfect",
                title: "Điểm 10 đầu tiên",
                description: "Đạt 100% trong một bài học",
                emoji: "💯",
                category: .perfect,
                requirement: 1
            ),
            Achievement(
                id: "5_perfect",
                title: "Xuất sắc",
                description: "Đạt 100% trong 5 bài học",
                emoji: "🎯",
                category: .perfect,
                requirement: 5
            ),
            Achievement(
                id: "10_perfect",
                title: "Hoàn hảo",
                description: "Đạt 100% trong 10 bài học",
                emoji: "💎",
                category: .perfect,
                requirement: 10
            ),

            // Special Achievements
            Achievement(
                id: "early_bird",
                title: "Chim sớm",
                description: "Học vào buổi sáng (6-9 giờ)",
                emoji: "🌅",
                category: .special,
                requirement: 1
            ),
            Achievement(
                id: "night_owl",
                title: "Cú đêm",
                description: "Học vào buổi tối (20-23 giờ)",
                emoji: "🦉",
                category: .special,
                requirement: 1
            ),
            Achievement(
                id: "speed_learner",
                title: "Tốc độ",
                description: "Hoàn thành 5 bài học trong 1 ngày",
                emoji: "⚡",
                category: .special,
                requirement: 5
            ),
            Achievement(
                id: "weekend_warrior",
                title: "Chiến binh cuối tuần",
                description: "Học cả thứ 7 và chủ nhật",
                emoji: "🗓️",
                category: .special,
                requirement: 1
            )
        ]

        // Progress will be loaded per user via loadAchievementsForUser()
    }

    func checkAchievements(lessonsCompleted: Int, currentStreak: Int, totalXP: Int, perfectScores: Int) {
        print("🏆 [Achievements] Checking with: lessons=\(lessonsCompleted), streak=\(currentStreak), xp=\(totalXP), perfect=\(perfectScores)")

        var newlyUnlocked: [Achievement] = []

        for index in achievements.indices {
            if achievements[index].isUnlocked {
                continue
            }

            var shouldUnlock = false
            var currentProgress = 0

            switch achievements[index].category {
            case .lessons:
                currentProgress = lessonsCompleted
                shouldUnlock = lessonsCompleted >= achievements[index].requirement
            case .streak:
                currentProgress = currentStreak
                shouldUnlock = currentStreak >= achievements[index].requirement
            case .xp:
                currentProgress = totalXP
                shouldUnlock = totalXP >= achievements[index].requirement
            case .perfect:
                currentProgress = perfectScores
                shouldUnlock = perfectScores >= achievements[index].requirement
            case .special:
                // Special achievements are checked separately
                currentProgress = achievements[index].progress
                shouldUnlock = achievements[index].progress >= achievements[index].requirement
            }

            achievements[index].progress = currentProgress

            if shouldUnlock {
                print("🎉 [Achievements] UNLOCKED: \(achievements[index].title) (progress: \(currentProgress)/\(achievements[index].requirement))")
                achievements[index].isUnlocked = true
                achievements[index].unlockedDate = Date()
                newlyUnlocked.append(achievements[index])
                SoundEffectService.shared.playLevelUpSound()
            }
        }

        if !newlyUnlocked.isEmpty {
            newlyUnlockedAchievements = newlyUnlocked
            if let userId = currentUserId {
                saveProgress(for: userId)
            }
        }
    }

    func checkSpecialAchievement(_ achievementId: String) {
        guard let index = achievements.firstIndex(where: { $0.id == achievementId }) else {
            return
        }

        if !achievements[index].isUnlocked {
            achievements[index].progress += 1
            if achievements[index].progress >= achievements[index].requirement {
                achievements[index].isUnlocked = true
                achievements[index].unlockedDate = Date()
                newlyUnlockedAchievements = [achievements[index]]
                SoundEffectService.shared.playLevelUpSound()
                if let userId = currentUserId {
                    saveProgress(for: userId)
                }
            }
        }
    }

    var unlockedCount: Int {
        achievements.filter { $0.isUnlocked }.count
    }

    var totalCount: Int {
        achievements.count
    }

    var completionPercentage: Double {
        Double(unlockedCount) / Double(totalCount)
    }

    // MARK: - Persistence
    private func saveProgress(for userId: String) {
        if let encoded = try? JSONEncoder().encode(achievements) {
            UserDefaults.standard.set(encoded, forKey: "achievements_\(userId)")
            print("📊 [Achievements] Saved achievements for user: \(userId)")
        }
    }

    private func loadProgress(for userId: String) {
        if let data = UserDefaults.standard.data(forKey: "achievements_\(userId)"),
           let decoded = try? JSONDecoder().decode([Achievement].self, from: data) {
            // Merge saved progress with default achievements
            for saved in decoded {
                if let index = achievements.firstIndex(where: { $0.id == saved.id }) {
                    achievements[index].isUnlocked = saved.isUnlocked
                    achievements[index].unlockedDate = saved.unlockedDate
                    achievements[index].progress = saved.progress
                }
            }
            print("📊 [Achievements] Loaded achievements for user: \(userId)")
            print("📊 [Achievements] Unlocked count: \(unlockedCount)/\(totalCount)")
        } else {
            print("📊 [Achievements] No saved achievements found for user: \(userId)")
        }
    }
}
