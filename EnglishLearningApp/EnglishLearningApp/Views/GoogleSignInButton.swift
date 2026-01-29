import SwiftUI
import GoogleSignIn
import FirebaseAuth

struct GoogleSignInButton: View {
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        Button(action: handleSignInWithGoogle) {
            HStack(spacing: 12) {
                Image(systemName: "g.circle.fill")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.white)

                Text("Đăng nhập bằng Google")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(Color.red)
            .cornerRadius(15)
        }
        .disabled(authViewModel.isLoading)
        .opacity(authViewModel.isLoading ? 0.6 : 1.0)
    }

    private func handleSignInWithGoogle() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else {
            print("Failed to get root view controller")
            return
        }

        // Get client ID from Firebase configuration
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            authViewModel.errorMessage = "Không tìm thấy Google Client ID"
            return
        }

        // Create Google Sign In configuration
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        // Start sign in flow
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { result, error in
            if let error = error {
                authViewModel.errorMessage = "Lỗi đăng nhập Google: \(error.localizedDescription)"
                return
            }

            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString else {
                authViewModel.errorMessage = "Không thể lấy thông tin đăng nhập từ Google"
                return
            }

            let accessToken = user.accessToken.tokenString

            // Sign in with Firebase using Google credentials
            authViewModel.signInWithGoogle(idToken: idToken, accessToken: accessToken)
        }
    }
}
