import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.presentationMode) var presentationMode

    @State private var email = ""
    @State private var name = ""
    @State private var password = ""
    @State private var confirmPassword = ""

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
                Text("Đăng ký")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.top, 60)

                Spacer()

                // Sign in with Apple
                VStack(spacing: 15) {
                    SignInWithAppleButton()
                        .frame(height: 50)
                        .padding(.horizontal, 40)
                        .accessibilityLabel("Đăng ký bằng Apple")
                        .accessibilityHint("Nhấn đúp để đăng ký nhanh bằng Apple ID")

                    // Divider
                    HStack {
                        Rectangle()
                            .fill(Color.white.opacity(0.3))
                            .frame(height: 1)
                        Text("hoặc đăng ký bằng email")
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
                    TextField("Tên của bạn", text: $name)
                        .textFieldStyle(RoundedTextFieldStyle())

                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedTextFieldStyle())
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)

                    SecureField("Mật khẩu", text: $password)
                        .textFieldStyle(RoundedTextFieldStyle())

                    SecureField("Xác nhận mật khẩu", text: $confirmPassword)
                        .textFieldStyle(RoundedTextFieldStyle())

                    if let error = authViewModel.errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                            .font(.caption)
                    }

                    Button(action: register) {
                        Text("Tạo tài khoản")
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

    private func register() {
        guard password == confirmPassword else {
            authViewModel.errorMessage = "Mật khẩu không khớp"
            return
        }

        authViewModel.register(email: email, name: name, password: password)
        if authViewModel.isAuthenticated {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

// Custom TextField Style
struct RoundedTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .background(Color.white)
            .cornerRadius(15)
            .foregroundColor(.black)
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
            .environmentObject(AuthViewModel())
    }
}
