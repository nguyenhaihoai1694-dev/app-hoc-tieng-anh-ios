import SwiftUI
import FirebaseFirestore

struct LeaderboardView: View {
    @EnvironmentObject var authViewModel: AuthViewModel

    @State private var leaderboardData: [LeaderboardUser] = []
    @State private var userRank: Int?
    @State private var isLoading = true

    private let firestoreService = FirestoreService.shared
    private var leaderboardListener: ListenerRegistration?

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Current User Rank
                    if let currentUser = authViewModel.currentUser {
                        CurrentUserRankCard(user: currentUser, rank: userRank)
                    }

                    // Loading Indicator
                    if isLoading {
                        ProgressView("Đang tải...")
                            .padding()
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
                setupRealtimeLeaderboard()
                loadUserRank()
            }
        }
    }

    // MARK: - Realtime Leaderboard
    private func setupRealtimeLeaderboard() {
        _ = firestoreService.listenToLeaderboard(limit: 50) { users in
            DispatchQueue.main.async {
                self.leaderboardData = users
                self.isLoading = false
            }
        }
    }

    // MARK: - Load User Rank
    private func loadUserRank() {
        guard let userId = authViewModel.currentUser?.id.uuidString else { return }

        Task {
            do {
                let rank = try await firestoreService.getUserRank(userId: userId)
                await MainActor.run {
                    self.userRank = rank
                }
            } catch {
                print("Error loading user rank: \(error.localizedDescription)")
            }
        }
    }
}

struct CurrentUserRankCard: View {
    let user: User
    let rank: Int?

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
                    Text(rank.map { "\($0)" } ?? "...")
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
    let entry: LeaderboardUser

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
                    Label("\(entry.totalXP) XP", systemImage: "star.fill")
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

struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardView()
            .environmentObject(AuthViewModel())
    }
}
