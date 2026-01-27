import SwiftUI

struct AchievementsView: View {
    @StateObject private var achievementManager = AchievementManager.shared
    @State private var selectedCategory: AchievementCategory?

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 25) {
                    // Header with progress
                    AchievementHeaderView(
                        unlockedCount: achievementManager.unlockedCount,
                        totalCount: achievementManager.totalCount,
                        percentage: achievementManager.completionPercentage
                    )

                    // Category filter
                    CategoryFilterView(selectedCategory: $selectedCategory)

                    // Achievements grid
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                        ForEach(filteredAchievements) { achievement in
                            AchievementCard(achievement: achievement)
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Thành tích")
        }
    }

    private var filteredAchievements: [Achievement] {
        if let category = selectedCategory {
            return achievementManager.achievements.filter { $0.category == category }
        }
        return achievementManager.achievements
    }
}

// MARK: - Achievement Header
struct AchievementHeaderView: View {
    let unlockedCount: Int
    let totalCount: Int
    let percentage: Double

    var body: some View {
        VStack(spacing: 15) {
            // Trophy icon
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [.yellow.opacity(0.3), .orange.opacity(0.3)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 100, height: 100)

                Text("🏆")
                    .font(.system(size: 50))
            }

            VStack(spacing: 5) {
                Text("\(unlockedCount)/\(totalCount)")
                    .font(.title)
                    .fontWeight(.bold)

                Text("Thành tích đã mở khóa")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            // Progress bar
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("Tiến độ")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Spacer()
                    Text("\(Int(percentage * 100))%")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                }

                ProgressView(value: percentage)
                    .tint(.blue)
                    .scaleEffect(x: 1, y: 2, anchor: .center)
            }
            .padding(.horizontal, 40)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 2)
        .padding(.horizontal)
    }
}

// MARK: - Category Filter
struct CategoryFilterView: View {
    @Binding var selectedCategory: AchievementCategory?

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                // All button
                CategoryButton(
                    title: "Tất cả",
                    icon: "square.grid.2x2",
                    color: .gray,
                    isSelected: selectedCategory == nil
                ) {
                    selectedCategory = nil
                }

                // Category buttons
                ForEach(AchievementCategory.allCases, id: \.self) { category in
                    CategoryButton(
                        title: category.rawValue,
                        icon: category.icon,
                        color: category.color,
                        isSelected: selectedCategory == category
                    ) {
                        selectedCategory = category
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

struct CategoryButton: View {
    let title: String
    let icon: String
    let color: Color
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.caption)
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.medium)
            }
            .foregroundColor(isSelected ? .white : color)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(isSelected ? color : color.opacity(0.15))
            .cornerRadius(20)
        }
    }
}

// MARK: - Achievement Card
struct AchievementCard: View {
    let achievement: Achievement

    var body: some View {
        VStack(spacing: 12) {
            // Emoji with lock overlay
            ZStack {
                Text(achievement.emoji)
                    .font(.system(size: 50))
                    .opacity(achievement.isUnlocked ? 1.0 : 0.3)

                if !achievement.isUnlocked {
                    Image(systemName: "lock.fill")
                        .font(.title2)
                        .foregroundColor(.gray)
                }
            }
            .frame(height: 60)

            VStack(spacing: 5) {
                Text(achievement.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .minimumScaleFactor(0.8)

                Text(achievement.description)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .minimumScaleFactor(0.8)
            }
            .padding(.horizontal, 8)

            // Progress or date
            if achievement.isUnlocked {
                if let date = achievement.unlockedDate {
                    Text(formatDate(date))
                        .font(.caption2)
                        .foregroundColor(.green)
                }
            } else {
                // Progress bar for locked achievements
                VStack(spacing: 4) {
                    ProgressView(value: achievement.progressPercentage)
                        .tint(achievement.category.color)
                        .scaleEffect(x: 1, y: 1.5, anchor: .center)

                    Text("\(achievement.progress)/\(achievement.requirement)")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: achievement.isUnlocked ? 3 : 1)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(achievement.isUnlocked ? achievement.category.color : Color.clear, lineWidth: 2)
        )
    }

    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: date)
    }
}

// MARK: - Achievement Unlock Notification
struct AchievementUnlockView: View {
    let achievement: Achievement
    let onDismiss: () -> Void

    @State private var isAnimating = false

    var body: some View {
        ZStack {
            // Semi-transparent background
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture {
                    onDismiss()
                }

            // Achievement card
            VStack(spacing: 20) {
                // Trophy animation
                Text("🎉")
                    .font(.system(size: 80))
                    .scaleEffect(isAnimating ? 1.0 : 0.5)
                    .rotationEffect(.degrees(isAnimating ? 360 : 0))
                    .animation(.spring(response: 0.8, dampingFraction: 0.6), value: isAnimating)

                Text("Thành tích mới!")
                    .font(.title)
                    .fontWeight(.bold)

                // Achievement details
                VStack(spacing: 10) {
                    Text(achievement.emoji)
                        .font(.system(size: 60))

                    Text(achievement.title)
                        .font(.title2)
                        .fontWeight(.semibold)

                    Text(achievement.description)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding()
                .background(achievement.category.color.opacity(0.1))
                .cornerRadius(15)

                Button(action: onDismiss) {
                    Text("Tuyệt vời!")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(achievement.category.color)
                        .cornerRadius(15)
                }
            }
            .padding(40)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 20)
            .padding(.horizontal, 40)
            .onAppear {
                isAnimating = true
            }
        }
    }
}

// MARK: - Preview
struct AchievementsView_Previews: PreviewProvider {
    static var previews: some View {
        AchievementsView()
    }
}
