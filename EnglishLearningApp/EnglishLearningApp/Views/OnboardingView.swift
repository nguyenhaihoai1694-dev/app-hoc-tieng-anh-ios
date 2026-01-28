import SwiftUI

struct OnboardingView: View {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    @State private var currentPage = 0
    let onComplete: () -> Void

    private let pages: [OnboardingPage] = [
        OnboardingPage(
            emoji: "👋",
            title: "Chào mừng đến với\nỨng dụng Học Tiếng Anh!",
            description: "Học tiếng Anh vui vẻ và hiệu quả dành cho trẻ em từ 6-12 tuổi",
            color: .blue
        ),
        OnboardingPage(
            emoji: "🎯",
            title: "Học qua trò chơi",
            description: "40+ bài học tương tác với câu hỏi đa dạng, phát âm chuẩn và điểm thưởng hấp dẫn",
            color: .green
        ),
        OnboardingPage(
            emoji: "🔊",
            title: "Luyện phát âm",
            description: "Nghe và học phát âm chuẩn với công nghệ Text-to-Speech tiên tiến",
            color: .purple
        ),
        OnboardingPage(
            emoji: "🏆",
            title: "Theo dõi tiến độ",
            description: "Nhận XP, thăng cấp, và duy trì streak mỗi ngày để trở thành cao thủ tiếng Anh",
            color: .orange
        ),
        OnboardingPage(
            emoji: "👨‍👩‍👧",
            title: "An toàn cho trẻ em",
            description: "Tuân thủ COPPA với Parent Gate và bảo vệ quyền riêng tư của trẻ",
            color: .pink
        )
    ]

    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                gradient: Gradient(colors: [pages[currentPage].color.opacity(0.3), pages[currentPage].color.opacity(0.1)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            .animation(.easeInOut(duration: 0.5), value: currentPage)

            VStack(spacing: 0) {
                // Skip button
                HStack {
                    Spacer()
                    if currentPage < pages.count - 1 {
                        Button(action: {
                            completeOnboarding()
                        }) {
                            Text("Bỏ qua")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .padding()
                        }
                        .accessibilityLabel("Bỏ qua giới thiệu")
                        .accessibilityHint("Nhấn đúp để bỏ qua các trang giới thiệu")
                    }
                }

                Spacer()

                // Page content
                TabView(selection: $currentPage) {
                    ForEach(0..<pages.count, id: \.self) { index in
                        OnboardingPageView(page: pages[index])
                            .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .frame(height: 500)

                // Page indicator
                HStack(spacing: 8) {
                    ForEach(0..<pages.count, id: \.self) { index in
                        Circle()
                            .fill(currentPage == index ? pages[currentPage].color : Color.gray.opacity(0.3))
                            .frame(width: currentPage == index ? 12 : 8, height: currentPage == index ? 12 : 8)
                            .animation(.easeInOut, value: currentPage)
                    }
                }
                .padding()
                .accessibilityElement(children: .ignore)
                .accessibilityLabel("Chỉ báo trang")
                .accessibilityValue("Trang \(currentPage + 1) trong \(pages.count)")

                Spacer()

                // Action button
                Button(action: {
                    if currentPage < pages.count - 1 {
                        withAnimation {
                            currentPage += 1
                        }
                    } else {
                        completeOnboarding()
                    }
                }) {
                    Text(currentPage < pages.count - 1 ? "Tiếp tục" : "Bắt đầu học")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(pages[currentPage].color)
                        .cornerRadius(15)
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 40)
                .accessibilityLabel(currentPage < pages.count - 1 ? "Tiếp tục" : "Bắt đầu học")
                .accessibilityHint(currentPage < pages.count - 1 ? "Nhấn đúp để chuyển sang trang tiếp theo" : "Nhấn đúp để bắt đầu học")
            }
        }
    }

    private func completeOnboarding() {
        hasCompletedOnboarding = true
        onComplete()
    }
}

struct OnboardingPage {
    let emoji: String
    let title: String
    let description: String
    let color: Color
}

struct OnboardingPageView: View {
    let page: OnboardingPage
    @State private var isAnimating = false

    var body: some View {
        VStack(spacing: 30) {
            // Emoji with animation
            Text(page.emoji)
                .font(.system(size: 100))
                .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
                .scaleEffect(isAnimating ? 1.0 : 0.8)
                .rotationEffect(.degrees(isAnimating ? 0 : -10))
                .animation(
                    Animation.spring(response: 0.8, dampingFraction: 0.6)
                        .repeatForever(autoreverses: true),
                    value: isAnimating
                )
                .onAppear {
                    isAnimating = true
                }
                .accessibilityLabel("Emoji minh họa: \(page.emoji)")

            VStack(spacing: 15) {
                Text(page.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.primary)
                    .padding(.horizontal)
                    .accessibilityAddTraits(.isHeader)

                Text(page.description)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 40)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding()
    }
}

// MARK: - Age Selection View (after onboarding)
struct AgeSelectionView: View {
    @Binding var selectedAge: Int?
    let onComplete: () -> Void

    private let ageGroups = [
        (range: "6-8", emoji: "👶", color: Color.blue),
        (range: "9-10", emoji: "🧒", color: Color.green),
        (range: "11-12", emoji: "👦", color: Color.purple),
        (range: "13+", emoji: "👨", color: Color.orange)
    ]

    var body: some View {
        VStack(spacing: 30) {
            Spacer()

            CompactMascotView(state: .waving, size: 70)
                .accessibilityLabel("Linh vật chào đón")
                .accessibilityValue("Đang vẫy tay chào bạn")

            VStack(spacing: 10) {
                Text("Bạn bao nhiêu tuổi?")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .accessibilityAddTraits(.isHeader)

                Text("Giúp chúng tôi tùy chỉnh nội dung phù hợp")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }

            VStack(spacing: 15) {
                ForEach(0..<ageGroups.count, id: \.self) { index in
                    let group = ageGroups[index]
                    Button(action: {
                        selectedAge = index
                        // Delay to show selection
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            onComplete()
                        }
                    }) {
                        HStack(spacing: 15) {
                            Text(group.emoji)
                                .font(.system(size: 40))

                            Text("\(group.range) tuổi")
                                .font(.system(size: 22, weight: .semibold))
                                .foregroundColor(.primary)

                            Spacer()

                            if selectedAge == index {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(group.color)
                                    .font(.title2)
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(selectedAge == index ? group.color.opacity(0.1) : Color.white)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(selectedAge == index ? group.color : Color.gray.opacity(0.2), lineWidth: 2)
                        )
                    }
                    .accessibilityLabel("Độ tuổi \(group.range)")
                    .accessibilityHint(selectedAge == index ? "Đã chọn" : "Nhấn đúp để chọn độ tuổi này")
                    .accessibilityAddTraits(selectedAge == index ? .isSelected : [])
                }
            }
            .padding(.horizontal, 30)

            Spacer()
        }
        .background(Color(.systemGroupedBackground))
    }
}

// MARK: - Preview
struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView {
            print("Onboarding completed")
        }
    }
}
