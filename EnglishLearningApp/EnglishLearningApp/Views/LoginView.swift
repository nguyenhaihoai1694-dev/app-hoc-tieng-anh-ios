import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.presentationMode) var presentationMode

    @State private var email = ""
    @State private var password = ""

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.blue, Color.purple]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 25) {
                // Title
                Text("Đăng nhập")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.top, 60)

                Spacer()

                // Sign in with Apple
                VStack(spacing: 15) {
                    SignInWithAppleButton()
                        .frame(height: 50)
                        .padding(.horizontal, 40)
                        .accessibilityLabel("Đăng nhập bằng Apple")
                        .accessibilityHint("Nhấn đúp để đăng nhập nhanh bằng Apple ID")

                    // Divider
                    HStack {
                        Rectangle()
                            .fill(Color.white.opacity(0.3))
                            .frame(height: 1)
                        Text("hoặc đăng nhập bằng email")
                            .font(.system(size: 14))
                            .foregroundColor(.white.opacity(0.7))
                        Rectangle()
                            .fill(Color.white.opacity(0.3))
                            .frame(height: 1)
                    }
                    .padding(.horizontal, 40)
                }

                // Form
                VStack(spacing: 20) {
                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedTextFieldStyle())
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)

                    SecureField("Mật khẩu", text: $password)
                        .textFieldStyle(RoundedTextFieldStyle())

                    if let error = authViewModel.errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                            .font(.caption)
                    }

                    Button(action: login) {
                        Text("Đăng nhập")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(15)
                    }
                }
                .padding(.horizontal, 40)

                Spacer()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }

    private func login() {
        authViewModel.login(email: email, password: password)
        if authViewModel.isAuthenticated {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AuthViewModel())
    }
}
