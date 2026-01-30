import Foundation
import Combine

class UserProgressManager: ObservableObject {
    @Published var completedLessons: Set<UUID> = []
    @Published var lessonScores: [UUID: Int] = [:]

    private let firestoreService = FirestoreService.shared

    init() {
        // Progress is loaded from Firestore via AuthViewModel
    }

    // MARK: - Complete Lesson with Firebase Sync
    func completeLesson(_ lessonId: UUID, score: Int, xpReward: Int, authViewModel: AuthViewModel) {
        print("📚 [ProgressManager] completeLesson called - lessonId: \(lessonId.uuidString), score: \(score)")

        // Update user stats
        guard var user = authViewModel.currentUser else {
            print("❌ [ProgressManager] ERROR: No current user found!")
            return
        }

        print("📚 [ProgressManager] Current user completedLessons before: \(user.completedLessons)")

        // Check if this is first time completing (based on Firebase user data - source of truth)
        let isFirstCompletion = !user.completedLessons.contains(lessonId.uuidString)
        let currentBest = lessonScores[lessonId] ?? 0
        let isBetterScore = score > currentBest

        print("📚 [ProgressManager] isFirstCompletion: \(isFirstCompletion), isBetterScore: \(isBetterScore)")

        // Mark as completed in local state
        completedLessons.insert(lessonId)

        // Update best score locally
        if isBetterScore {
            lessonScores[lessonId] = score
        }

        // Only award XP on first completion
        if isFirstCompletion {
            user.totalXP += xpReward

            // Add to completed lessons if not already there
            if !user.completedLessons.contains(lessonId.uuidString) {
                user.completedLessons.append(lessonId.uuidString)
            }

            // Level up logic
            while user.totalXP >= user.nextLevelXP {
                user.level += 1
            }

            // Update streak (only on first completion of the day)
            updateStreak(for: &user)
        }

        // Check achievements (always check for score improvements)
        let perfectScores = lessonScores.values.filter { $0 == 100 }.count
        AchievementManager.shared.checkAchievements(
            lessonsCompleted: user.completedLessons.count,
            currentStreak: user.currentStreak,
            totalXP: user.totalXP,
            perfectScores: perfectScores
        )

        // Save to Firebase
        Task {
            do {
                print("💾 [ProgressManager] Saving to Firebase...")

                // Save lesson progress (always save for score tracking)
                try await firestoreService.saveLessonProgress(
                    userId: user.id,
                    lessonId: lessonId.uuidString,
                    score: score,
                    xpEarned: isFirstCompletion ? xpReward : 0
                )
                print("✅ [ProgressManager] Lesson progress saved to Firestore")

                // Update user in Firestore (only if first completion)
                if isFirstCompletion {
                    try await firestoreService.updateUser(user)
                    print("✅ [ProgressManager] User updated in Firestore with completedLessons: \(user.completedLessons)")
                } else {
                    print("ℹ️ [ProgressManager] Skipping user update (retake, not first completion)")
                }

                // Update local state
                await MainActor.run {
                    authViewModel.currentUser = user
                    print("✅ [ProgressManager] Local authViewModel.currentUser updated")
                    print("📚 [ProgressManager] Current user completedLessons after: \(authViewModel.currentUser?.completedLessons ?? [])")
                }
            } catch {
                print("❌ [ProgressManager] ERROR saving progress: \(error.localizedDescription)")
            }
        }
    }

    // MARK: - Load Progress from Firebase
    func loadProgress(for userId: String) {
        Task {
            do {
                let progressData = try await firestoreService.getUserProgress(userId: userId)

                await MainActor.run {
                    var completed: Set<UUID> = []
                    var scores: [UUID: Int] = [:]

                    for progress in progressData {
                        if let lessonIdString = progress["lessonId"] as? String,
                           let lessonId = UUID(uuidString: lessonIdString),
                           let score = progress["score"] as? Int {
                            completed.insert(lessonId)
                            scores[lessonId] = score
                        }
                    }

                    self.completedLessons = completed
                    self.lessonScores = scores
                }
            } catch {
                print("Error loading progress: \(error.localizedDescription)")
            }
        }
    }

    // MARK: - Check Lesson Status
    func isLessonCompleted(_ lessonId: UUID) -> Bool {
        return completedLessons.contains(lessonId)
    }

    func getScore(for lessonId: UUID) -> Int? {
        return lessonScores[lessonId]
    }

    // MARK: - Streak Management
    private func updateStreak(for user: inout User) {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())

        if let lastActive = user.lastActiveDate as? Date {
            let lastActiveDay = calendar.startOfDay(for: lastActive)
            let daysDifference = calendar.dateComponents([.day], from: lastActiveDay, to: today).day ?? 0

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

        user.lastActiveDate = Date()

        if user.currentStreak > user.longestStreak {
            user.longestStreak = user.currentStreak
        }

        // Update streak in Firebase
        let userId = user.id
        let currentStreak = user.currentStreak
        Task {
            do {
                try await firestoreService.updateUserStreak(
                    userId: userId,
                    streak: currentStreak
                )
            } catch {
                print("Error updating streak: \(error.localizedDescription)")
            }
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
