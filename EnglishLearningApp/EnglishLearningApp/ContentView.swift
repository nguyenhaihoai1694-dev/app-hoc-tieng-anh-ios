import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        // Skip login - go directly to main app
        MainTabView()
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
