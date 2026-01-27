import Foundation
import StoreKit
import Combine

@MainActor
class SubscriptionManager: ObservableObject {
    @Published var subscriptionStatus = SubscriptionStatus()
    @Published var isPurchasing = false
    @Published var purchaseError: String?

    private let iapManager = IAPManager.shared
    private var cancellables = Set<AnyCancellable>()

    init() {
        loadSubscriptionStatus()

        // Listen to IAP updates
        iapManager.$purchasedSubscriptions
            .sink { [weak self] _ in
                Task { @MainActor in
                    self?.updateSubscriptionFromIAP()
                }
            }
            .store(in: &cancellables)
    }

    // MARK: - Purchase

    func purchase(_ product: StoreKit.Product) async -> Bool {
        isPurchasing = true
        purchaseError = nil

        do {
            let transaction = try await iapManager.purchase(product)

            if transaction != nil {
                updateSubscriptionFromIAP()
                isPurchasing = false
                return true
            } else {
                isPurchasing = false
                return false
            }
        } catch {
            isPurchasing = false
            purchaseError = error.localizedDescription
            return false
        }
    }

    // MARK: - Restore Purchases

    func restorePurchases() async {
        isPurchasing = true
        await iapManager.restorePurchases()
        updateSubscriptionFromIAP()
        isPurchasing = false
    }

    // MARK: - Subscription Status

    func hasActiveSubscription() -> Bool {
        return iapManager.hasActiveSubscription()
    }

    private func updateSubscriptionFromIAP() {
        // Update based on purchased subscriptions
        if let subscription = iapManager.purchasedSubscriptions.first {
            let plan = planFromProductID(subscription.id)
            let expiryDate = calculateExpiryDate(for: subscription)

            subscriptionStatus.currentPlan = plan
            subscriptionStatus.isActive = true
            subscriptionStatus.expiryDate = expiryDate
            subscriptionStatus.autoRenew = subscription.type == .autoRenewable
            saveSubscriptionStatus()
        } else {
            subscriptionStatus.currentPlan = .free
            subscriptionStatus.isActive = false
            subscriptionStatus.expiryDate = nil
            subscriptionStatus.autoRenew = false
            saveSubscriptionStatus()
        }
    }

    private func planFromProductID(_ productID: String) -> SubscriptionPlan {
        switch productID {
        case IAPManager.ProductID.weekly.rawValue:
            return .weekly
        case IAPManager.ProductID.monthly.rawValue:
            return .monthly
        case IAPManager.ProductID.yearly.rawValue:
            return .yearly
        case IAPManager.ProductID.family.rawValue:
            return .family
        case IAPManager.ProductID.lifetime.rawValue:
            return .lifetime
        default:
            return .free
        }
    }

    private func calculateExpiryDate(for product: StoreKit.Product) -> Date? {
        guard let subscription = product.subscription else {
            // Lifetime - no expiry
            return nil
        }

        let period = subscription.subscriptionPeriod
        let calendar = Calendar.current
        let now = Date()

        switch period.unit {
        case .day:
            return calendar.date(byAdding: .day, value: period.value, to: now)
        case .week:
            return calendar.date(byAdding: .weekOfYear, value: period.value, to: now)
        case .month:
            return calendar.date(byAdding: .month, value: period.value, to: now)
        case .year:
            return calendar.date(byAdding: .year, value: period.value, to: now)
        @unknown default:
            return nil
        }
    }

    // MARK: - Persistence

    private func saveSubscriptionStatus() {
        if let encoded = try? JSONEncoder().encode(subscriptionStatus) {
            UserDefaults.standard.set(encoded, forKey: "subscriptionStatus")
        }
    }

    private func loadSubscriptionStatus() {
        guard let data = UserDefaults.standard.data(forKey: "subscriptionStatus"),
              let status = try? JSONDecoder().decode(SubscriptionStatus.self, from: data) else {
            return
        }
        subscriptionStatus = status
    }
}
