import Foundation

// LeaderboardUser model for displaying users in leaderboard
struct LeaderboardUser: Identifiable {
    let id: String
    let name: String
    let totalXP: Int
    let level: Int
}
