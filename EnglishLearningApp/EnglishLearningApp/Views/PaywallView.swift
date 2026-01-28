import SwiftUI
import StoreKit

struct PaywallView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var subscriptionManager: SubscriptionManager
    @EnvironmentObject var authViewModel: AuthViewModel
    @StateObject private var iapManager = IAPManager.shared
    @StateObject private var localizationManager = LocalizationManager.shared

    @State private var selectedProduct: Product?
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var showParentGate = false

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
                    VStack(spacing: 25) {
                        // Header
                        VStack(spacing: 15) {
                            Image(systemName: "crown.fill")
                                .resizable()
                                .frame(width: 80, height: 60)
                                .foregroundColor(.yellow)

                            Text(localizationManager.currentLanguage == .vietnamese ?
                                 "Nâng cấp Premium" : "Upgrade to Premium")
                                .font(.system(size: 32, weight: .bold))
                                .foregroundColor(.white)

                            Text(localizationManager.currentLanguage == .vietnamese ?
                                 "Học không giới hạn với tất cả tính năng cao cấp" :
                                 "Unlimited learning with all premium features")
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white.opacity(0.9))
                                .padding(.horizontal)
                        }
                        .padding(.top, 40)

                        // Features
                        VStack(spacing: 15) {
                            FeatureRow(icon: "heart.fill", title: localizationManager.currentLanguage == .vietnamese ?
                                      "❤️ Trái tim không giới hạn" : "❤️ Unlimited Hearts")
                            FeatureRow(icon: "book.fill", title: localizationManager.currentLanguage == .vietnamese ?
                                      "📚 Tất cả 40 bài học Premium" : "📚 All 40 Premium Lessons")
                            FeatureRow(icon: "speaker.wave.2.fill", title: localizationManager.currentLanguage == .vietnamese ?
                                      "🔊 Luyện phát âm với TTS" : "🔊 Pronunciation Practice")
                            FeatureRow(icon: "chart.bar.fill", title: localizationManager.currentLanguage == .vietnamese ?
                                      "📊 Theo dõi tiến độ chi tiết" : "📊 Detailed Progress Tracking")
                            FeatureRow(icon: "xmark.circle.fill", title: localizationManager.currentLanguage == .vietnamese ?
                                      "🚫 Không quảng cáo" : "🚫 No Ads")
                            FeatureRow(icon: "trophy.fill", title: localizationManager.currentLanguage == .vietnamese ?
                                      "🏆 Achievements đặc biệt" : "🏆 Special Achievements")
                        }
                        .padding(.horizontal)

                        // Pricing Cards
                        if iapManager.products.isEmpty {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .padding()
                        } else {
                            VStack(spacing: 15) {
                                ForEach(iapManager.products, id: \.id) { product in
                                    ProductCard(
                                        product: product,
                                        isSelected: selectedProduct?.id == product.id,
                                        badge: badgeForProduct(product)
                                    ) {
                                        selectedProduct = product
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }

                        // Subscribe Button
                        Button(action: {
                            if selectedProduct != nil {
                                showParentGate = true
                            }
                        }) {
                            if subscriptionManager.isPurchasing {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                            } else {
                                HStack {
                                    Image(systemName: "crown.fill")
                                    Text(selectedProduct?.subscription != nil ?
                                         (localizationManager.currentLanguage == .vietnamese ?
                                          "Đăng ký Premium" :
                                          "Subscribe to Premium") :
                                         (localizationManager.currentLanguage == .vietnamese ?
                                          "Mua Lifetime Premium" :
                                          "Purchase Lifetime Premium"))
                                        .font(.headline)
                                }
                                .foregroundColor(.blue)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                        .padding(.horizontal)
                        .disabled(subscriptionManager.isPurchasing || selectedProduct == nil)
                        .opacity(selectedProduct == nil ? 0.6 : 1.0)

                        // Restore Button
                        Button(action: restorePurchases) {
                            Text(localizationManager.currentLanguage == .vietnamese ?
                                 "Khôi phục gói đã mua" : "Restore Purchases")
                                .font(.subheadline)
                                .foregroundColor(.white)
                        }

                        // Terms
                        Text(localizationManager.currentLanguage == .vietnamese ?
                             "Tự động gia hạn. Hủy bất kỳ lúc nào." :
                             "Auto-renewable. Cancel anytime.")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.7))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                            .padding(.bottom, 30)
                    }
                }
            }
            .navigationBarItems(trailing: Button(localizationManager.currentLanguage == .vietnamese ?
                                                 "Đóng" : "Close") {
                presentationMode.wrappedValue.dismiss()
            })
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text(localizationManager.currentLanguage == .vietnamese ?
                               "Thông báo" : "Notice"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
            .fullScreenCover(isPresented: $showParentGate) {
                ParentGateView {
                    // Parent gate passed - proceed with purchase
                    subscribe()
                }
            }
            .onAppear {
                // Pre-select the $3 monthly plan (most popular)
                if selectedProduct == nil {
                    selectedProduct = iapManager.product(for: .month1) ?? iapManager.products.first
                }
            }
        }
    }

    private func badgeForProduct(_ product: Product) -> String? {
        switch product.id {
        case IAPManager.ProductID.month1.rawValue:
            return localizationManager.currentLanguage == .vietnamese ?
                   "Phổ biến nhất ⭐" : "Most Popular ⭐"
        case IAPManager.ProductID.year1.rawValue:
            return localizationManager.currentLanguage == .vietnamese ?
                   "Tiết kiệm nhất 💰" : "Best Savings 💰"
        case IAPManager.ProductID.lifetime.rawValue:
            return localizationManager.currentLanguage == .vietnamese ?
                   "Giá trị tốt nhất 👑" : "Best Value 👑"
        default:
            return nil
        }
    }

    private func subscribe() {
        guard let product = selectedProduct else { return }

        Task {
            let success = await subscriptionManager.purchase(product)

            if success {
                if var user = authViewModel.currentUser {
                    user.isPremium = true
                    user.subscriptionExpiryDate = subscriptionManager.subscriptionStatus.expiryDate
                    authViewModel.updateUser(user)
                }
                alertMessage = localizationManager.currentLanguage == .vietnamese ?
                               "Đăng ký thành công! Chào mừng bạn đến với Premium!" :
                               "Successfully subscribed! Welcome to Premium!"
                showAlert = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    presentationMode.wrappedValue.dismiss()
                }
            } else if let error = subscriptionManager.purchaseError {
                alertMessage = error
                showAlert = true
            }
        }
    }

    private func restorePurchases() {
        Task {
            await subscriptionManager.restorePurchases()

            if subscriptionManager.hasActiveSubscription() {
                alertMessage = localizationManager.currentLanguage == .vietnamese ?
                               "Khôi phục thành công!" : "Successfully restored!"
            } else {
                alertMessage = localizationManager.currentLanguage == .vietnamese ?
                               "Không tìm thấy gói đăng ký nào" : "No purchases found"
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

struct ProductCard: View {
    let product: Product
    let isSelected: Bool
    var badge: String? = nil
    let action: () -> Void

    @StateObject private var localizationManager = LocalizationManager.shared

    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 10) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(product.displayName)
                            .font(.headline)
                            .foregroundColor(isSelected ? .white : .primary)

                        Text(product.displayPrice)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(isSelected ? .white : .primary)

                        if let subscription = product.subscription {
                            Text("/ \(subscription.subscriptionPeriod.unit == .year ? (localizationManager.currentLanguage == .vietnamese ? "năm" : "year") : subscription.subscriptionPeriod.unit == .month ? (localizationManager.currentLanguage == .vietnamese ? "tháng" : "month") : (localizationManager.currentLanguage == .vietnamese ? "tuần" : "week"))")
                                .font(.caption)
                                .foregroundColor(isSelected ? .white.opacity(0.8) : .secondary)
                        } else {
                            Text(localizationManager.currentLanguage == .vietnamese ?
                                 "Mua 1 lần" : "One-time purchase")
                                .font(.caption)
                                .foregroundColor(isSelected ? .white.opacity(0.8) : .secondary)
                        }

                        // Show savings for year1 ($50)
                        if product.id == IAPManager.ProductID.year1.rawValue {
                            Text(localizationManager.currentLanguage == .vietnamese ?
                                 "Tiết kiệm 58% 🔥" : "Save 58% 🔥")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(isSelected ? .yellow : .orange)
                        }
                    }

                    Spacer()

                    VStack(spacing: 8) {
                        if let badge = badge {
                            Text(badge)
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .background(Color.green.opacity(0.8))
                                .cornerRadius(10)
                        }

                        if isSelected {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.white)
                                .font(.title2)
                        }
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
