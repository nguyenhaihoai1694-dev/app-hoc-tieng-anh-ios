import SwiftUI
import FirebaseCore
import FirebaseAppCheck

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      // Use debug provider only in debug builds, production provider in release
      #if DEBUG
      let providerFactory = AppCheckDebugProviderFactory()
      #else
      let providerFactory = AppAttestProviderFactory()
      #endif

      AppCheck.setAppCheckProviderFactory(providerFactory)
      FirebaseApp.configure()

    return true
  }
}

@main
struct EnglishLearningAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
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
