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
                    VStack(spacing: 20) {
                        // Sign in with Apple
                        SignInWithAppleButton()
                            .frame(height: 55)
                            .accessibilityLabel("Đăng nhập bằng Apple")
                            .accessibilityHint("Nhấn đúp để đăng nhập nhanh bằng Apple ID")

                        // Google Sign-in Button
                        GoogleSignInButton()
                            .accessibilityLabel("Đăng nhập bằng Google")
                            .accessibilityHint("Nhấn đúp để đăng nhập bằng tài khoản Google")
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
