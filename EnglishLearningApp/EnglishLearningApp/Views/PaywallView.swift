import SwiftUI

struct PaywallView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var subscriptionManager: SubscriptionManager
    @EnvironmentObject var authViewModel: AuthViewModel

    @State private var selectedPlan: SubscriptionPlan = .yearly
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.purple, Color.blue]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 30) {
                        // Header
                        VStack(spacing: 15) {
                            Image(systemName: "crown.fill")
                                .resizable()
                                .frame(width: 80, height: 60)
                                .foregroundColor(.yellow)

                            Text("Nâng cấp Premium")
                                .font(.system(size: 32, weight: .bold))
                                .foregroundColor(.white)

                            Text("Học không giới hạn với tất cả tính năng cao cấp")
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white.opacity(0.9))
                                .padding(.horizontal)
                        }
                        .padding(.top, 40)

                        // Features
                        VStack(spacing: 15) {
                            FeatureRow(icon: "infinity", title: "Không giới hạn bài học")
                            FeatureRow(icon: "speaker.wave.2.fill", title: "Luyện phát âm với AI")
                            FeatureRow(icon: "chart.line.uptrend.xyaxis", title: "Theo dõi tiến độ chi tiết")
                            FeatureRow(icon: "arrow.down.circle.fill", title: "Tải bài học offline")
                            FeatureRow(icon: "xmark.circle.fill", title: "Không quảng cáo")
                            FeatureRow(icon: "checkmark.seal.fill", title: "Chứng chỉ hoàn thành")
                        }
                        .padding(.horizontal)

                        // Pricing Cards
                        VStack(spacing: 15) {
                            PricingCard(
                                plan: .yearly,
                                isSelected: selectedPlan == .yearly,
                                badge: "Tiết kiệm 33%"
                            ) {
                                selectedPlan = .yearly
                            }

                            PricingCard(
                                plan: .monthly,
                                isSelected: selectedPlan == .monthly
                            ) {
                                selectedPlan = .monthly
                            }
                        }
                        .padding(.horizontal)

                        // Subscribe Button
                        Button(action: subscribe) {
                            if subscriptionManager.isPurchasing {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                            } else {
                                Text("Bắt đầu dùng thử miễn phí 7 ngày")
                                    .font(.headline)
                                    .foregroundColor(.blue)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                        .padding(.horizontal)
                        .disabled(subscriptionManager.isPurchasing)

                        // Restore Button
                        Button(action: restorePurchases) {
                            Text("Khôi phục gói đã mua")
                                .font(.subheadline)
                                .foregroundColor(.white)
                        }

                        // Terms
                        Text("Tự động gia hạn. Hủy bất kỳ lúc nào.")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.7))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                            .padding(.bottom, 30)
                    }
                }
            }
            .navigationBarItems(trailing: Button("Đóng") {
                presentationMode.wrappedValue.dismiss()
            })
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Thông báo"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }

    private func subscribe() {
        subscriptionManager.purchase(selectedPlan) { success, error in
            if success {
                if var user = authViewModel.currentUser {
                    user.isPremium = true
                    user.subscriptionExpiryDate = subscriptionManager.subscriptionStatus.expiryDate
                    authViewModel.updateUser(user)
                }
                alertMessage = "Đăng ký thành công! Chào mừng bạn đến với Premium!"
                showAlert = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    presentationMode.wrappedValue.dismiss()
                }
            } else if let error = error {
                alertMessage = error.localizedDescription
                showAlert = true
            }
        }
    }

    private func restorePurchases() {
        subscriptionManager.restorePurchases { success, error in
            if success {
                alertMessage = "Khôi phục thành công!"
            } else {
                alertMessage = error?.localizedDescription ?? "Không tìm thấy gói đăng ký nào"
            }
            showAlert = true
        }
    }
}

struct FeatureRow: View {
    let icon: String
    let title: String

    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .foregroundColor(.green)
                .font(.title3)
                .frame(width: 30)

            Text(title)
                .foregroundColor(.white)
                .font(.body)

            Spacer()
        }
    }
}

struct PricingCard: View {
    let plan: SubscriptionPlan
    let isSelected: Bool
    var badge: String? = nil
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(plan.displayName)
                            .font(.headline)
                            .foregroundColor(isSelected ? .white : .primary)

                        Text(plan.price)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(isSelected ? .white : .primary)

                        if plan == .yearly {
                            Text("$6.67/tháng")
                                .font(.caption)
                                .foregroundColor(isSelected ? .white.opacity(0.8) : .secondary)
                        }
                    }

                    Spacer()

                    if let badge = badge {
                        Text(badge)
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.green)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(Color.green.opacity(0.2))
                            .cornerRadius(10)
                    }

                    if isSelected {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.white)
                            .font(.title2)
                    }
                }
            }
            .padding()
            .background(isSelected ? Color.blue : Color.white)
            .cornerRadius(15)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(isSelected ? Color.white : Color.gray.opacity(0.3), lineWidth: 2)
            )
        }
    }
}

struct PaywallView_Previews: PreviewProvider {
    static var previews: some View {
        PaywallView()
            .environmentObject(SubscriptionManager())
            .environmentObject(AuthViewModel())
    }
}
