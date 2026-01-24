import SwiftUI

struct LeaderboardView: View {
    @EnvironmentObject var authViewModel: AuthViewModel

    @State private var leaderboardData: [LeaderboardEntry] = []

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Current User Rank
                    if let currentUser = authViewModel.currentUser {
                        CurrentUserRankCard(user: currentUser)
                    }

                    // Leaderboard List
                    VStack(spacing: 0) {
                        ForEach(Array(leaderboardData.enumerated()), id: \.element.id) { index, entry in
                            LeaderboardRow(rank: index + 1, entry: entry)

                            if index < leaderboardData.count - 1 {
                                Divider()
                                    .padding(.leading, 70)
                            }
                        }
                    }
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(radius: 2)
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Bảng xếp hạng")
            .onAppear {
                loadLeaderboard()
            }
        }
    }

    private func loadLeaderboard() {
        // Sample data - In production, fetch from server
        leaderboardData = [
            LeaderboardEntry(name: "Nguyễn Văn A", xp: 2500, level: 15),
            LeaderboardEntry(name: "Trần Thị B", xp: 2100, level: 13),
            LeaderboardEntry(name: "Lê Văn C", xp: 1800, level: 12),
            LeaderboardEntry(name: "Phạm Thị D", xp: 1500, level: 10),
            LeaderboardEntry(name: "Hoàng Văn E", xp: 1200, level: 9),
            LeaderboardEntry(name: "Vũ Thị F", xp: 1000, level: 8),
            LeaderboardEntry(name: "Đặng Văn G", xp: 800, level: 7),
            LeaderboardEntry(name: "Bùi Thị H", xp: 600, level: 6),
        ]
    }
}

struct CurrentUserRankCard: View {
    let user: User

    var body: some View {
        VStack(spacing: 15) {
            Text("Xếp hạng của bạn")
                .font(.headline)
                .foregroundColor(.secondary)

            HStack(spacing: 20) {
                // Avatar
                ZStack {
                    Circle()
                        .fill(LinearGradient(
                            gradient: Gradient(colors: [.blue, .purple]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                        .frame(width: 60, height: 60)

                    Text(user.name.prefix(1).uppercased())
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }

                VStack(alignment: .leading, spacing: 5) {
                    Text(user.name)
                        .font(.headline)

                    HStack {
                        Label("\(user.totalXP) XP", systemImage: "star.fill")
                            .font(.caption)
                            .foregroundColor(.orange)

                        Text("•")
                            .foregroundColor(.secondary)

                        Text("Cấp \(user.level)")
                            .font(.caption)
                            .foregroundColor(.blue)
                    }
                }

                Spacer()

                VStack {
                    Text("#")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("?")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(15)
            .shadow(radius: 2)
        }
        .padding(.horizontal)
    }
}

struct LeaderboardRow: View {
    let rank: Int
    let entry: LeaderboardEntry

    var body: some View {
        HStack(spacing: 15) {
            // Rank
            Text("#\(rank)")
                .font(.headline)
                .foregroundColor(rankColor)
                .frame(width: 40)

            // Avatar
            ZStack {
                Circle()
                    .fill(rankColor.opacity(0.2))
                    .frame(width: 50, height: 50)

                Text(entry.name.prefix(1).uppercased())
                    .font(.headline)
                    .foregroundColor(rankColor)
            }

            // Info
            VStack(alignment: .leading, spacing: 5) {
                Text(entry.name)
                    .font(.body)
                    .fontWeight(.semibold)

                HStack {
                    Label("\(entry.xp) XP", systemImage: "star.fill")
                        .font(.caption)
                        .foregroundColor(.orange)

                    Text("•")
                        .foregroundColor(.secondary)
                        .font(.caption)

                    Text("Cấp \(entry.level)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            Spacer()

            // Medal for top 3
            if rank <= 3 {
                Image(systemName: "medal.fill")
                    .foregroundColor(rankColor)
                    .font(.title2)
            }
        }
        .padding()
    }

    private var rankColor: Color {
        switch rank {
        case 1: return .yellow
        case 2: return .gray
        case 3: return .orange
        default: return .blue
        }
    }
}

struct LeaderboardEntry: Identifiable {
    let id = UUID()
    let name: String
    let xp: Int
    let level: Int
}

struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardView()
            .environmentObject(AuthViewModel())
    }
}
