import SwiftUI
import AuthenticationServices

struct SignInWithAppleButton: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        SignInWithAppleButtonViewRepresentable()
            .frame(height: 50)
            .cornerRadius(15)
            .onTapGesture {
                handleSignInWithApple()
            }
    }

    private func handleSignInWithApple() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]

        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = authViewModel.appleSignInDelegate
        controller.performRequests()
    }
}

struct SignInWithAppleButtonViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        let button = ASAuthorizationAppleIDButton(type: .signIn, style: .black)
        button.cornerRadius = 15
        return button
    }

    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {}
}
