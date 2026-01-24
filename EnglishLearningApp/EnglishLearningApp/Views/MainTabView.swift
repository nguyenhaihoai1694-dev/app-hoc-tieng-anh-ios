import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label("Học", systemImage: "book.fill")
                }
                .tag(0)

            LeaderboardView()
                .tabItem {
                    Label("Xếp hạng", systemImage: "chart.bar.fill")
                }
                .tag(1)

            ProfileView()
                .tabItem {
                    Label("Hồ sơ", systemImage: "person.fill")
                }
                .tag(2)
        }
        .accentColor(.blue)
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
