import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    @State private var showOnboarding = false

    var body: some View {
        Group {
            if !hasCompletedOnboarding {
                // First time: show onboarding
                OnboardingView {
                    hasCompletedOnboarding = true
                }
            } else if !authViewModel.isAuthenticated {
                // Onboarding completed but not logged in: show welcome/login
                WelcomeView()
            } else {
                // Logged in: show main app
                MainTabView()
            }
        }
        .onAppear {
            showOnboarding = !hasCompletedOnboarding
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AuthViewModel())
            .environmentObject(SubscriptionManager())
            .environmentObject(UserProgressManager())
    }
}
