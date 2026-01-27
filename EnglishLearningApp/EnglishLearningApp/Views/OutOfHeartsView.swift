import SwiftUI

/// View shown when user runs out of hearts
struct OutOfHeartsView: View {
    @StateObject private var heartManager = HeartManager.shared
    @StateObject private var localizationManager = LocalizationManager.shared
    @Environment(\.dismiss) private var dismiss

    let onUpgrade: () -> Void

    @State private var timeRemaining = ""
    @State private var timer: Timer?

    var body: some View {
        ZStack {
            // Background
            LinearGradient(
                gradient: Gradient(colors: [Color.red.opacity(0.1), Color.orange.opacity(0.1)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 30) {
                Spacer()

                // Broken heart animation
                ZStack {
                    Circle()
                        .fill(Color.red.opacity(0.1))
                        .frame(width: 150, height: 150)

                    Text("💔")
                        .font(.system(size: 80))
                }

                // Title
                VStack(spacing: 10) {
                    Text(localizationManager.currentLanguage == .vietnamese ?
                         "Hết trái tim rồi!" : "Out of Hearts!")
                        .font(.system(size: 32, weight: .bold))

                    Text(localizationManager.currentLanguage == .vietnamese ?
                         "Bạn đã dùng hết \(heartManager.maxHearts) trái tim hôm nay" :
                         "You've used all \(heartManager.maxHearts) hearts today")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }

                // Options
                VStack(spacing: 20) {
                    // Option 1: Wait for refill
                    VStack(spacing: 15) {
                        HStack {
                            Image(systemName: "clock.fill")
                                .foregroundColor(.blue)
                                .font(.title2)

                            VStack(alignment: .leading, spacing: 5) {
                                Text(localizationManager.currentLanguage == .vietnamese ?
                                     "Đợi trái tim mới" : "Wait for New Hearts")
                                    .font(.headline)

                                Text(localizationManager.currentLanguage == .vietnamese ?
                                     "Trái tim sẽ đầy lại sau: \(timeRemaining)" :
                                     "Hearts refill in: \(timeRemaining)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }

                            Spacer()
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(radius: 2)
                    }
                    .padding(.horizontal)

                    // Option 2: Upgrade to Premium
                    Button(action: {
                        dismiss()
                        onUpgrade()
                    }) {
                        HStack(spacing: 15) {
                            Image(systemName: "crown.fill")
                                .foregroundColor(.yellow)
                                .font(.title2)

                            VStack(alignment: .leading, spacing: 5) {
                                Text(localizationManager.currentLanguage == .vietnamese ?
                                     "Nâng cấp Premium" : "Upgrade to Premium")
                                    .font(.headline)
                                    .foregroundColor(.white)

                                Text(localizationManager.currentLanguage == .vietnamese ?
                                     "Trái tim không giới hạn!" : "Unlimited Hearts!")
                                    .font(.subheadline)
                                    .foregroundColor(.white.opacity(0.9))
                            }

                            Spacer()

                            Image(systemName: "arrow.right.circle.fill")
                                .foregroundColor(.white)
                                .font(.title2)
                        }
                        .padding()
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [.orange, .red]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(15)
                        .shadow(radius: 5)
                    }
                    .padding(.horizontal)

                    // Practice option (coming soon)
                    VStack(spacing: 15) {
                        HStack {
                            Image(systemName: "book.fill")
                                .foregroundColor(.green)
                                .font(.title2)

                            VStack(alignment: .leading, spacing: 5) {
                                Text(localizationManager.currentLanguage == .vietnamese ?
                                     "Luyện tập để kiếm trái tim" : "Practice to Earn Hearts")
                                    .font(.headline)

                                Text(localizationManager.currentLanguage == .vietnamese ?
                                     "Sắp ra mắt!" : "Coming soon!")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }

                            Spacer()

                            Text("🔒")
                                .font(.title2)
                        }
                        .padding()
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(15)
                    }
                    .padding(.horizontal)
                }

                Spacer()

                // Close button
                Button(action: {
                    dismiss()
                }) {
                    Text(localizationManager.currentLanguage == .vietnamese ?
                         "Đóng" : "Close")
                        .font(.headline)
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                }
                .padding(.horizontal)
                .padding(.bottom, 30)
            }
        }
        .onAppear {
            updateTimeRemaining()
            // Update every minute
            timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { _ in
                updateTimeRemaining()
            }
        }
        .onDisappear {
            timer?.invalidate()
        }
    }

    private func updateTimeRemaining() {
        timeRemaining = heartManager.formattedTimeUntilRefill()
    }
}

/// Heart display component for navigation bar
struct HeartDisplay: View {
    @StateObject private var heartManager = HeartManager.shared

    var body: some View {
        HStack(spacing: 5) {
            Image(systemName: "heart.fill")
                .foregroundColor(heartManager.heartColor)
                .font(.title3)

            Text("\(heartManager.currentHearts)")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(heartManager.heartColor)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(heartManager.heartColor.opacity(0.15))
        .cornerRadius(20)
    }
}

/// Compact heart indicator
struct CompactHeartDisplay: View {
    @StateObject private var heartManager = HeartManager.shared

    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "heart.fill")
                .foregroundColor(heartManager.heartColor)
                .font(.caption)

            Text("\(heartManager.currentHearts)")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(heartManager.heartColor)
        }
    }
}

struct OutOfHeartsView_Previews: PreviewProvider {
    static var previews: some View {
        OutOfHeartsView {
            print("Upgrade tapped")
        }
    }
}
