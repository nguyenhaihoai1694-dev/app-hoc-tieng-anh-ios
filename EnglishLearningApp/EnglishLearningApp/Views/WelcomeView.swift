import SwiftUI

struct WelcomeView: View {
    @State private var showLogin = false

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue, Color.purple]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack(spacing: 30) {
                    Spacer()

                    // App Icon
                    Image(systemName: "book.fill")
                        .resizable()
                        .frame(width: 120, height: 120)
                        .foregroundColor(.white)
                        .accessibilityLabel("Biểu tượng ứng dụng học tiếng Anh")

                    // Title
                    Text("English Learning")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .accessibilityAddTraits(.isHeader)

                    Text("Học tiếng Anh mỗi ngày")
                        .font(.title3)
                        .foregroundColor(.white)

                    Spacer()

                    // Buttons
                    VStack(spacing: 15) {
                        NavigationLink(destination: RegisterView()) {
                            Text("Bắt đầu học")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(.blue)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(15)
                        }
                        .accessibilityLabel("Bắt đầu học")
                        .accessibilityHint("Nhấn đúp để tạo tài khoản mới và bắt đầu học")

                        NavigationLink(destination: LoginView()) {
                            Text("Đã có tài khoản")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white.opacity(0.2))
                                .cornerRadius(15)
                        }
                        .accessibilityLabel("Đã có tài khoản")
                        .accessibilityHint("Nhấn đúp để đăng nhập bằng tài khoản đã có")
                    }
                    .padding(.horizontal, 40)
                    .padding(.bottom, 50)
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
