import SwiftUI

struct HomeView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var subscriptionManager: SubscriptionManager
    @EnvironmentObject var progressManager: UserProgressManager
    @StateObject private var heartManager = HeartManager.shared
    @StateObject private var localizationManager = LocalizationManager.shared

    @State private var lessons: [Lesson] = []
    @State private var showPaywall = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Header with streak
                    HeaderView()

                    // Mascot Welcome
                    MascotView(state: .waving, size: 60)
                        .padding(.vertical, 10)

                    // Stats Card
                    StatsCard()

                    // Lessons Section
                    VStack(alignment: .leading, spacing: 15) {
                        Text(localizationManager.localized(.yourLessons))
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal)

                        ForEach(lessons) { lesson in
                            LessonCard(lesson: lesson)
                        }
                    }
                }
                .padding(.vertical)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Học tiếng Anh")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if !subscriptionManager.hasActiveSubscription() {
                        HeartDisplay()
                    }
                }
            }
            .onAppear {
                loadLessons()
                heartManager.checkDailyRefill()
            }
            .sheet(isPresented: $showPaywall) {
                PaywallView()
            }
        }
    }

    private func loadLessons() {
        lessons = LessonDataService.shared.getLessons()
    }
}

struct HeaderView: View {
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Xin chào, \(authViewModel.currentUser?.name ?? "")!")
                    .font(.title2)
                    .fontWeight(.bold)

                Text("Tiếp tục học nào!")
                    .foregroundColor(.secondary)
            }

            Spacer()

            // Streak
            HStack(spacing: 5) {
                Image(systemName: "flame.fill")
                    .foregroundColor(.orange)
                Text("\(authViewModel.currentUser?.currentStreak ?? 0)")
                    .font(.headline)
                    .fontWeight(.bold)
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 8)
            .background(Color.orange.opacity(0.1))
            .cornerRadius(20)
        }
        .padding()
        .background(Color.white)
    }
}

struct StatsCard: View {
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        VStack(spacing: 15) {
            HStack(spacing: 20) {
                StatItem(
                    icon: "star.fill",
                    value: "\(authViewModel.currentUser?.totalXP ?? 0)",
                    label: "XP",
                    color: .yellow
                )

                Divider()

                StatItem(
                    icon: "chart.line.uptrend.xyaxis",
                    value: "\(authViewModel.currentUser?.level ?? 1)",
                    label: "Cấp độ",
                    color: .blue
                )

                Divider()

                StatItem(
                    icon: "flame.fill",
                    value: "\(authViewModel.currentUser?.longestStreak ?? 0)",
                    label: "Streak cao nhất",
                    color: .orange
                )
            }
            .frame(height: 80)

            // Progress Bar
            if let user = authViewModel.currentUser {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Tiến độ lên cấp \(user.level + 1)")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    ProgressView(value: user.progressToNextLevel)
                        .tint(.blue)

                    Text("\(user.totalXP) / \(user.nextLevelXP) XP")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 2)
        .padding(.horizontal)
    }
}

struct StatItem: View {
    let icon: String
    let value: String
    let label: String
    let color: Color

    var body: some View {
        VStack(spacing: 5) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)

            Text(value)
                .font(.title3)
                .fontWeight(.bold)

            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
    }
}

struct LessonCard: View {
    @EnvironmentObject var subscriptionManager: SubscriptionManager
    @EnvironmentObject var progressManager: UserProgressManager
    @StateObject private var heartManager = HeartManager.shared
    @State private var showStudy = false
    @State private var showQuiz = false
    @State private var showPaywall = false
    @State private var showOutOfHearts = false

    let lesson: Lesson

    var body: some View {
        Button(action: onTap) {
            HStack {
                // Icon
                ZStack {
                    Circle()
                        .fill(iconBackgroundColor)
                        .frame(width: 60, height: 60)

                    Image(systemName: iconName)
                        .font(.title2)
                        .foregroundColor(.white)
                }

                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Text(lesson.title)
                            .font(.headline)
                            .foregroundColor(.primary)

                        if lesson.isPremium {
                            Image(systemName: "crown.fill")
                                .foregroundColor(.yellow)
                                .font(.caption)
                        }
                    }

                    Text(lesson.description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(2)

                    HStack {
                        Label("\(lesson.xpReward) XP", systemImage: "star.fill")
                            .font(.caption)
                            .foregroundColor(.orange)

                        if let score = progressManager.getScore(for: lesson.id) {
                            Spacer()
                            Text("Điểm cao nhất: \(score)%")
                                .font(.caption)
                                .foregroundColor(.green)
                        }
                    }
                }

                Spacer()

                if progressManager.isLessonCompleted(lesson.id) {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                        .font(.title2)
                } else {
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(15)
            .shadow(radius: 2)
        }
        .padding(.horizontal)
        .sheet(isPresented: $showStudy) {
            LearningContentView(lesson: lesson) {
                // Start quiz after studying
                showStudy = false
                showQuiz = true
            }
        }
        .sheet(isPresented: $showQuiz) {
            LessonView(lesson: lesson)
        }
        .sheet(isPresented: $showPaywall) {
            PaywallView()
        }
        .fullScreenCover(isPresented: $showOutOfHearts) {
            OutOfHeartsView {
                showOutOfHearts = false
                showPaywall = true
            }
        }
    }

    private var iconBackgroundColor: Color {
        if progressManager.isLessonCompleted(lesson.id) {
            return .green
        } else if lesson.isPremium {
            return .purple
        } else {
            return .blue
        }
    }

    private var iconName: String {
        if progressManager.isLessonCompleted(lesson.id) {
            return "checkmark"
        } else {
            return "book.fill"
        }
    }

    private func onTap() {
        // Check Premium first
        if lesson.isPremium && !subscriptionManager.hasActiveSubscription() {
            showPaywall = true
            return
        }

        // Check hearts (only for non-Premium users)
        if !subscriptionManager.hasActiveSubscription() && !heartManager.hasHearts() {
            showOutOfHearts = true
            return
        }

        // Show study phase first
        showStudy = true
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(AuthViewModel())
            .environmentObject(SubscriptionManager())
            .environmentObject(UserProgressManager())
    }
}
