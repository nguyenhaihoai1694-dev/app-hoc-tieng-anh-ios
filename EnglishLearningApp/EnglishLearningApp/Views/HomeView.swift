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
                        .accessibilityLabel("Linh vật chào đón")
                        .accessibilityValue("Đang vẫy tay chào bạn")

                    // Stats Card
                    StatsCard()

                    // Lessons Section
                    VStack(alignment: .leading, spacing: 15) {
                        Text(localizationManager.localized(.yourLessons))
                            .font(.system(size: 26, weight: .bold))
                            .padding(.horizontal)
                            .accessibilityAddTraits(.isHeader)

                        ForEach(lessons) { lesson in
                            LessonCard(lesson: lesson, onRefreshNeeded: loadLessons)
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
        // Get completed lesson IDs from user progress
        let completedIds = authViewModel.currentUser?.completedLessons ?? []

        print("🏠 [HomeView] loadLessons called")
        print("🏠 [HomeView] completedIds from user: \(completedIds)")

        // Load lessons with lock status based on sequential progression
        lessons = LessonDataService.shared.getlessonsWithLockStatus(completedLessonIds: completedIds)

        print("🏠 [HomeView] Total lessons loaded: \(lessons.count)")
        print("🏠 [HomeView] Lesson lock status:")
        for (index, lesson) in lessons.prefix(5).enumerated() {
            print("  - Lesson \(index + 1): '\(lesson.title)' - isLocked: \(lesson.isLocked)")
        }
    }
}

struct HeaderView: View {
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Xin chào, \(authViewModel.currentUser?.name ?? "")!")
                    .font(.system(size: 24, weight: .bold))
                    .accessibilityLabel("Xin chào, \(authViewModel.currentUser?.name ?? "")!")

                Text("Tiếp tục học nào!")
                    .font(.system(size: 18))
                    .foregroundColor(.secondary)
            }

            Spacer()

            // Streak
            HStack(spacing: 5) {
                Image(systemName: "flame.fill")
                    .foregroundColor(.orange)
                    .font(.title3)
                Text("\(authViewModel.currentUser?.currentStreak ?? 0)")
                    .font(.system(size: 20, weight: .bold))
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 8)
            .background(Color.orange.opacity(0.1))
            .cornerRadius(20)
            .accessibilityElement(children: .combine)
            .accessibilityLabel("Chuỗi ngày học liên tiếp")
            .accessibilityValue("\(authViewModel.currentUser?.currentStreak ?? 0) ngày")
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
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)

                    ProgressView(value: user.progressToNextLevel)
                        .tint(.blue)
                        .accessibilityLabel("Tiến độ lên cấp \(user.level + 1)")
                        .accessibilityValue("\(Int(user.progressToNextLevel * 100)) phần trăm")

                    Text("\(user.totalXP) / \(user.nextLevelXP) XP")
                        .font(.system(size: 14))
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
                .font(.system(size: 22, weight: .bold))

            Text(label)
                .font(.system(size: 14))
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(label): \(value)")
    }
}

struct LessonCard: View {
    @EnvironmentObject var subscriptionManager: SubscriptionManager
    @EnvironmentObject var progressManager: UserProgressManager
    @EnvironmentObject var authViewModel: AuthViewModel
    @StateObject private var heartManager = HeartManager.shared
    @State private var showStudy = false
    @State private var showQuiz = false
    @State private var showPaywall = false
    @State private var showOutOfHearts = false

    let lesson: Lesson
    var onRefreshNeeded: (() -> Void)?

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
                    Text(lesson.title)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.primary)

                    Text(lesson.description)
                        .font(.system(size: 16))
                        .foregroundColor(.secondary)
                        .lineLimit(2)

                    HStack {
                        Label("\(lesson.xpReward) XP", systemImage: "star.fill")
                            .font(.system(size: 14))
                            .foregroundColor(.orange)

                        if let score = progressManager.getScore(for: lesson.id) {
                            Spacer()
                            Text("Điểm cao nhất: \(score)%")
                                .font(.system(size: 14))
                                .foregroundColor(.green)
                        }
                    }
                }

                Spacer()

                if lesson.isLocked {
                    Image(systemName: "lock.fill")
                        .foregroundColor(.gray)
                        .font(.title2)
                } else if progressManager.isLessonCompleted(lesson.id) {
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
            .shadow(radius: lesson.isLocked ? 0 : 2)
            .opacity(lesson.isLocked ? 0.5 : 1.0)
        }
        .padding(.horizontal)
        .disabled(lesson.isLocked)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(buildAccessibilityLabel())
        .accessibilityHint("Nhấn đúp để bắt đầu bài học")
        .accessibilityAddTraits(.isButton)
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
        .onChange(of: showQuiz) { newValue in
            // When quiz is dismissed, refresh lessons to update lock status
            print("🎯 [LessonCard] showQuiz changed to: \(newValue)")
            if !newValue {
                print("🎯 [LessonCard] Quiz dismissed, refreshing lessons...")
                onRefreshNeeded?()
            }
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
        if lesson.isLocked {
            return .gray
        } else if progressManager.isLessonCompleted(lesson.id) {
            return .green
        } else {
            return .blue
        }
    }

    private var iconName: String {
        if lesson.isLocked {
            return "lock.fill"
        } else if progressManager.isLessonCompleted(lesson.id) {
            return "checkmark"
        } else {
            return "book.fill"
        }
    }

    private func buildAccessibilityLabel() -> String {
        var label = "Bài học: \(lesson.title). "
        label += "\(lesson.description). "
        label += "Phần thưởng: \(lesson.xpReward) XP. "

        if lesson.isLocked {
            label += "Bài học bị khóa. Hoàn thành bài học trước để mở khóa."
            return label
        }

        if let score = progressManager.getScore(for: lesson.id) {
            label += "Điểm cao nhất: \(score) phần trăm. "
        }

        if progressManager.isLessonCompleted(lesson.id) {
            label += "Đã hoàn thành."
        }

        return label
    }

    private func onTap() {
        // Check if lesson is locked (must complete previous lesson first)
        if lesson.isLocked {
            // Lesson is disabled, this shouldn't be called due to .disabled()
            // But adding as safety check
            return
        }

        // Check hearts (only for non-Premium users)
        // This is the main Premium value proposition - unlimited hearts
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
