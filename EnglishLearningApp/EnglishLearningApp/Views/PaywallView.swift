import SwiftUI
import StoreKit

struct PaywallView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var subscriptionManager: SubscriptionManager
    @EnvironmentObject var authViewModel: AuthViewModel
    @StateObject private var iapManager = IAPManager.shared

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
                                .accessibilityLabel("Biểu tượng vương miện Premium")

                            Text("Nâng cấp Premium")
                                .font(.system(size: 32, weight: .bold))
                                .foregroundColor(.white)
                                .accessibilityAddTraits(.isHeader)

                            Text("Học không giới hạn với tất cả tính năng cao cấp")
                                .font(.system(size: 18))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                                .padding(.horizontal)
                        }
                        .padding(.top, 40)

                        // Features
                        VStack(spacing: 15) {
                            FeatureRow(icon: "heart.fill", title: "❤️ Trái tim không giới hạn")
                            FeatureRow(icon: "book.fill", title: "📚 Tất cả 40 bài học Premium")
                            FeatureRow(icon: "speaker.wave.2.fill", title: "🔊 Luyện phát âm với TTS")
                            FeatureRow(icon: "chart.bar.fill", title: "📊 Theo dõi tiến độ chi tiết")
                            FeatureRow(icon: "xmark.circle.fill", title: "🚫 Không quảng cáo")
                            FeatureRow(icon: "trophy.fill", title: "🏆 Thành tích đặc biệt")
                        }
                        .padding(.horizontal)

                        // Pricing Cards
                        if iapManager.products.isEmpty {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .padding()
                                .accessibilityLabel("Đang tải các gói Premium")
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
                                        .font(.title3)
                                    Text(selectedProduct?.subscription != nil ?
                                          "Đăng ký Premium" : "Mua Lifetime Premium")
                                        .font(.system(size: 20, weight: .semibold))
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
                        .accessibilityLabel(selectedProduct?.subscription != nil ?
                              "Đăng ký Premium" : "Mua Lifetime Premium")
                        .accessibilityHint("Nhấn đúp để tiếp tục thanh toán")

                        // Restore Button
                        Button(action: restorePurchases) {
                            Text("Khôi phục gói đã mua")
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                        }
                        .accessibilityLabel("Khôi phục gói đã mua")
                        .accessibilityHint("Nhấn đúp để khôi phục các gói đã mua trước đó")

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
            return "Phổ biến nhất ⭐"
        case IAPManager.ProductID.year1.rawValue:
            return "Tiết kiệm nhất 💰"
        case IAPManager.ProductID.lifetime.rawValue:
            return "Giá trị tốt nhất 👑"
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
                alertMessage = "Đăng ký thành công! Chào mừng bạn đến với Premium!"
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
                alertMessage = "Khôi phục thành công!"
            } else {
                alertMessage = "Không tìm thấy gói đăng ký nào"
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
                .font(.system(size: 18))

            Spacer()
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Tính năng: \(title)")
    }
}

struct ProductCard: View {
    let product: Product
    let isSelected: Bool
    var badge: String? = nil
    let action: () -> Void

    // Vietnamese product names
    private var vietnameseProductName: String {
        switch product.id {
        case IAPManager.ProductID.week1.rawValue:
            return "Gói 1 Tuần"
        case IAPManager.ProductID.month1.rawValue:
            return "Gói 1 Tháng"
        case IAPManager.ProductID.month2.rawValue:
            return "Gói 2 Tháng"
        case IAPManager.ProductID.month3.rawValue:
            return "Gói 3 Tháng"
        case IAPManager.ProductID.month6.rawValue:
            return "Gói 6 Tháng"
        case IAPManager.ProductID.year1.rawValue:
            return "Gói 1 Năm"
        case IAPManager.ProductID.lifetime.rawValue:
            return "Gói Trọn Đời"
        default:
            return product.displayName
        }
    }

    private var periodText: String {
        switch product.id {
        case IAPManager.ProductID.week1.rawValue:
            return "/ tuần"
        case IAPManager.ProductID.month1.rawValue,
             IAPManager.ProductID.month2.rawValue,
             IAPManager.ProductID.month3.rawValue,
             IAPManager.ProductID.month6.rawValue:
            return "/ tháng"
        case IAPManager.ProductID.year1.rawValue:
            return "/ năm"
        case IAPManager.ProductID.lifetime.rawValue:
            return "Mua 1 lần, dùng mãi mãi"
        default:
            return ""
        }
    }

    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 10) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(vietnameseProductName)
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(isSelected ? .white : .primary)

                        Text(product.displayPrice)
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(isSelected ? .white : .primary)

                        Text(periodText)
                            .font(.system(size: 14))
                            .foregroundColor(isSelected ? .white : .secondary)

                        // Show savings for year1 ($50)
                        if product.id == IAPManager.ProductID.year1.rawValue {
                            Text("Tiết kiệm 58% 🔥")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(isSelected ? .yellow : .orange)
                        }
                    }

                    Spacer()

                    VStack(spacing: 8) {
                        if let badge = badge {
                            Text(badge)
                                .font(.system(size: 12, weight: .semibold))
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
        .accessibilityElement(children: .combine)
        .accessibilityLabel(buildAccessibilityLabel())
        .accessibilityHint(isSelected ? "Đã chọn" : "Nhấn đúp để chọn gói này")
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }

    private func buildAccessibilityLabel() -> String {
        var label = "\(vietnameseProductName), giá \(product.displayPrice)"

        if product.subscription != nil {
            label += " \(periodText)"
        } else {
            label += ", mua 1 lần"
        }

        if let badge = badge {
            label += ". \(badge)"
        }

        if product.id == IAPManager.ProductID.year1.rawValue {
            label += ". Tiết kiệm 58 phần trăm"
        }

        return label
    }
}

struct PaywallView_Previews: PreviewProvider {
    static var previews: some View {
        PaywallView()
            .environmentObject(SubscriptionManager())
            .environmentObject(AuthViewModel())
    }
}
