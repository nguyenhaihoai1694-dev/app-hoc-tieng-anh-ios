import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var subscriptionManager: SubscriptionManager
    @StateObject private var localizationManager = LocalizationManager.shared

    @State private var showPaywall = false
    @State private var showSettings = false
    @State private var showPrivacyPolicy = false
    @State private var showTermsOfService = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 25) {
                    // Profile Header
                    VStack(spacing: 15) {
                        // Avatar
                        ZStack {
                            Circle()
                                .fill(LinearGradient(
                                    gradient: Gradient(colors: [.blue, .purple]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ))
                                .frame(width: 100, height: 100)

                            Text(authViewModel.currentUser?.name.prefix(1).uppercased() ?? "U")
                                .font(.system(size: 40, weight: .bold))
                                .foregroundColor(.white)
                        }

                        Text(authViewModel.currentUser?.name ?? "")
                            .font(.title2)
                            .fontWeight(.bold)

                        Text(authViewModel.currentUser?.email ?? "")
                            .font(.subheadline)
                            .foregroundColor(.secondary)

                        // Premium Badge
                        if subscriptionManager.hasActiveSubscription() {
                            HStack {
                                Image(systemName: "crown.fill")
                                    .foregroundColor(.yellow)
                                Text("Premium")
                                    .fontWeight(.semibold)
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 8)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [.yellow.opacity(0.3), .orange.opacity(0.3)]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(20)
                        }
                    }
                    .padding(.top, 20)

                    // Stats Grid
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                        StatCard(
                            icon: "star.fill",
                            title: "Tổng XP",
                            value: "\(authViewModel.currentUser?.totalXP ?? 0)",
                            color: .yellow
                        )

                        StatCard(
                            icon: "chart.line.uptrend.xyaxis",
                            title: "Cấp độ",
                            value: "\(authViewModel.currentUser?.level ?? 1)",
                            color: .blue
                        )

                        StatCard(
                            icon: "flame.fill",
                            title: "Streak hiện tại",
                            value: "\(authViewModel.currentUser?.currentStreak ?? 0)",
                            color: .orange
                        )

                        StatCard(
                            icon: "flame.fill",
                            title: "Streak cao nhất",
                            value: "\(authViewModel.currentUser?.longestStreak ?? 0)",
                            color: .red
                        )
                    }
                    .padding(.horizontal)

                    // Premium/Subscription Section
                    Button(action: { showPaywall = true }) {
                        HStack {
                            Image(systemName: "crown.fill")
                                .foregroundColor(.yellow)

                            VStack(alignment: .leading) {
                                if subscriptionManager.hasActiveSubscription() {
                                    Text("Quản lý gói đăng ký")
                                        .font(.headline)
                                        .foregroundColor(.primary)

                                    Text("Xem thông tin gói Premium của bạn")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                } else {
                                    Text("Nâng cấp Premium")
                                        .font(.headline)
                                        .foregroundColor(.primary)

                                    Text("Mở khóa tất cả tính năng")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }

                            Spacer()

                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(radius: 2)
                    }
                    .padding(.horizontal)

                    // Settings
                    VStack(spacing: 0) {
                        SettingsRow(icon: "gear", title: "Cài đặt", color: .gray) {
                            showSettings = true
                        }

                        Divider()
                            .padding(.leading, 50)

                        SettingsRow(icon: "doc.text", title: "Chính Sách Bảo Mật", color: .blue) {
                            showPrivacyPolicy = true
                        }

                        Divider()
                            .padding(.leading, 50)

                        SettingsRow(icon: "doc.plaintext", title: "Điều Khoản Dịch Vụ", color: .blue) {
                            showTermsOfService = true
                        }

                        Divider()
                            .padding(.leading, 50)

                        SettingsRow(icon: "arrow.right.square", title: "Đăng xuất", color: .red) {
                            authViewModel.logout()
                        }
                    }
                    .background(Color.white)
                    .cornerRadius(15)
                    .padding(.horizontal)

                    Spacer()
                }
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle(localizationManager.localized(.profile))
            .sheet(isPresented: $showPaywall) {
                PaywallView()
            }
            .sheet(isPresented: $showPrivacyPolicy) {
                PrivacyPolicyView()
            }
            .sheet(isPresented: $showTermsOfService) {
                TermsOfServiceView()
            }
            .sheet(isPresented: $showSettings) {
                SettingsView()
            }
        }
    }
}

struct StatCard: View {
    let icon: String
    let title: String
    let value: String
    let color: Color

    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: icon)
                .font(.title)
                .foregroundColor(color)

            Text(value)
                .font(.title2)
                .fontWeight(.bold)

            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 2)
    }
}

struct SettingsRow: View {
    let icon: String
    let title: String
    let color: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(color)
                    .frame(width: 30)

                Text(title)
                    .foregroundColor(.primary)

                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
                    .font(.caption)
            }
            .padding()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(AuthViewModel())
            .environmentObject(SubscriptionManager())
    }
}
