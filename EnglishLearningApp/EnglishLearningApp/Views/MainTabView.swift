import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var progressManager: UserProgressManager
    @StateObject private var localizationManager = LocalizationManager.shared
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label(localizationManager.localized(.tabLearn), systemImage: "book.fill")
                }
                .tag(0)

            LeaderboardView()
                .tabItem {
                    Label(localizationManager.localized(.tabLeaderboard), systemImage: "chart.bar.fill")
                }
                .tag(1)

            AchievementsView()
                .tabItem {
                    Label(localizationManager.localized(.tabAchievements), systemImage: "trophy.fill")
                }
                .tag(2)

            ProfileView()
                .tabItem {
                    Label(localizationManager.localized(.tabProfile), systemImage: "person.fill")
                }
                .tag(3)
        }
        .accentColor(.blue)
        .onAppear {
            // Load user progress when main tab view appears
            if let userId = authViewModel.currentUser?.id {
                progressManager.loadProgress(for: userId)
            }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
            .environmentObject(AuthViewModel())
            .environmentObject(SubscriptionManager())
            .environmentObject(UserProgressManager())
    }
}
