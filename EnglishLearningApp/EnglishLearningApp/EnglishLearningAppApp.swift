import SwiftUI
import FirebaseCore
import FirebaseAppCheck
import DeviceCheck

// MARK: - App Check Configuration
// Set this to false to disable App Check for TestFlight testing
// Set to true when ready for production with App Check enforced on Firebase Console
let ENABLE_APP_CHECK = false

// Custom App Check provider factory that falls back gracefully
class CustomAppCheckProviderFactory: NSObject, AppCheckProviderFactory {
    func createProvider(with app: FirebaseApp) -> AppCheckProvider? {
        // Always use Debug provider for both DEBUG and TestFlight testing
        // This ensures the app works while testing IAP on TestFlight
        #if DEBUG
        print("🔧 [AppCheck] DEBUG build - Using Debug provider")
        return AppCheckDebugProvider(app: app)
        #else
        // For TestFlight/Release: Use Debug provider for now to avoid blocking
        // TODO: Switch to App Attest when ready for production
        print("🔧 [AppCheck] RELEASE build - Using Debug provider for TestFlight testing")
        return AppCheckDebugProvider(app: app)

        // Uncomment below for production with App Attest:
        /*
        if #available(iOS 14.0, *), DCAppAttestService.shared.isSupported {
            print("🔐 [AppCheck] Using App Attest provider")
            return AppAttestProvider(app: app)
        } else {
            print("📱 [AppCheck] App Attest not supported, using DeviceCheck provider")
            return DeviceCheckProvider(app: app)
        }
        */
        #endif
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        // Configure App Check (optional - can be disabled for testing)
        if ENABLE_APP_CHECK {
            let providerFactory = CustomAppCheckProviderFactory()
            AppCheck.setAppCheckProviderFactory(providerFactory)
            print("🔐 [App] App Check enabled")
        } else {
            print("⚠️ [App] App Check DISABLED for TestFlight testing")
        }

        // Configure Firebase
        FirebaseApp.configure()
        print("✅ [App] Firebase configured successfully")

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
