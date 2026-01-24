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

                    // Title
                    Text("English Learning")
                        .font(.system(size: 42, weight: .bold))
                        .foregroundColor(.white)

                    Text("Học tiếng Anh mỗi ngày")
                        .font(.title3)
                        .foregroundColor(.white.opacity(0.9))

                    Spacer()

                    // Buttons
                    VStack(spacing: 15) {
                        NavigationLink(destination: RegisterView()) {
                            Text("Bắt đầu học")
                                .font(.headline)
                                .foregroundColor(.blue)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(15)
                        }

                        NavigationLink(destination: LoginView()) {
                            Text("Đã có tài khoản")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white.opacity(0.2))
                                .cornerRadius(15)
                        }
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
