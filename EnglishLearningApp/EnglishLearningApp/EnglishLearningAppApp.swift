import SwiftUI

@main
struct EnglishLearningAppApp: App {
    @StateObject private var authViewModel = AuthViewModel()
    @StateObject private var subscriptionManager = SubscriptionManager()
    @StateObject private var userProgressManager = UserProgressManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authViewModel)
                .environmentObject(subscriptionManager)
                .environmentObject(userProgressManager)
        }
    }
}
