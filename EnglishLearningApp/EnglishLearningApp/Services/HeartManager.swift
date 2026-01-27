import Foundation
import SwiftUI

/// Heart system similar to Duolingo
/// Users have limited hearts (70) per day
/// Lose hearts on wrong answers, regain at midnight or with Premium
class HeartManager: ObservableObject {
    static let shared = HeartManager()

    @Published var currentHearts: Int = 70
    @Published var maxHearts: Int = 70
    @Published var lastRefillDate: Date = Date()

    private let heartsKey = "userHearts"
    private let lastRefillKey = "lastHeartRefill"
    private let heartsLostPerWrongAnswer = 10

    private init() {
        loadHearts()
        checkDailyRefill()
    }

    // MARK: - Public Methods

    /// Lose hearts when answering incorrectly
    func loseHearts() {
        currentHearts = max(0, currentHearts - heartsLostPerWrongAnswer)
        saveHearts()
    }

    /// Check if user has enough hearts to continue
    func hasHearts() -> Bool {
        return currentHearts >= heartsLostPerWrongAnswer
    }

    /// Refill hearts (for Premium users)
    func refillHearts() {
        currentHearts = maxHearts
        saveHearts()
    }

    /// Check and refill hearts if a day has passed
    func checkDailyRefill() {
        let calendar = Calendar.current
        let now = Date()

        // Check if it's a new day
        if !calendar.isDate(lastRefillDate, inSameDayAs: now) {
            refillHearts()
            lastRefillDate = now
            UserDefaults.standard.set(lastRefillDate, forKey: lastRefillKey)
        }
    }

    /// Get time until next refill
    func timeUntilRefill() -> TimeInterval {
        let calendar = Calendar.current
        let now = Date()

        // Get start of tomorrow
        if let tomorrow = calendar.date(byAdding: .day, value: 1, to: now),
           let startOfTomorrow = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: tomorrow) {
            return startOfTomorrow.timeIntervalSince(now)
        }

        return 0
    }

    /// Format time remaining as string
    func formattedTimeUntilRefill() -> String {
        let timeRemaining = timeUntilRefill()
        let hours = Int(timeRemaining) / 3600
        let minutes = Int(timeRemaining) / 60 % 60

        if hours > 0 {
            return String(format: "%dh %02dm", hours, minutes)
        } else {
            return String(format: "%dm", minutes)
        }
    }

    /// Get heart percentage (for UI)
    var heartPercentage: Double {
        return Double(currentHearts) / Double(maxHearts)
    }

    // MARK: - Private Methods

    private func saveHearts() {
        UserDefaults.standard.set(currentHearts, forKey: heartsKey)
    }

    private func loadHearts() {
        currentHearts = UserDefaults.standard.integer(forKey: heartsKey)

        // First time setup
        if currentHearts == 0 {
            currentHearts = maxHearts
        }

        if let savedDate = UserDefaults.standard.object(forKey: lastRefillKey) as? Date {
            lastRefillDate = savedDate
        }
    }
}

/// Heart display colors
extension HeartManager {
    var heartColor: Color {
        let percentage = heartPercentage
        if percentage > 0.6 {
            return .green
        } else if percentage > 0.3 {
            return .orange
        } else {
            return .red
        }
    }
}
