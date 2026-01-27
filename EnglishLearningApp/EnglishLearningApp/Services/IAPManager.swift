import Foundation
import StoreKit

@MainActor
class IAPManager: ObservableObject {
    static let shared = IAPManager()

    @Published private(set) var products: [Product] = []
    @Published private(set) var purchasedSubscriptions: [Product] = []
    @Published private(set) var subscriptionGroupStatus: RenewalState?

    private var updateListenerTask: Task<Void, Error>?

    // Product IDs
    enum ProductID: String, CaseIterable {
        case weekly = "com.englishlearning.app.weekly"
        case monthly = "com.englishlearning.app.monthly"
        case yearly = "com.englishlearning.app.yearly"
        case family = "com.englishlearning.app.family"
        case lifetime = "com.englishlearning.app.lifetime"
    }

    enum RenewalState {
        case subscribed
        case expired
        case inGracePeriod
        case inBillingRetryPeriod
        case revoked
    }

    private init() {
        // Start listening for transaction updates
        updateListenerTask = listenForTransactions()

        Task {
            await loadProducts()
            await updateCustomerProductStatus()
        }
    }

    deinit {
        updateListenerTask?.cancel()
    }

    // MARK: - Load Products

    func loadProducts() async {
        do {
            let storeProducts = try await Product.products(for: ProductID.allCases.map { $0.rawValue })

            DispatchQueue.main.async {
                self.products = storeProducts.sorted(by: { $0.price < $1.price })
            }
        } catch {
            print("Failed to load products: \(error)")
        }
    }

    // MARK: - Purchase

    func purchase(_ product: Product) async throws -> Transaction? {
        let result = try await product.purchase()

        switch result {
        case .success(let verification):
            let transaction = try checkVerified(verification)

            await updateCustomerProductStatus()

            await transaction.finish()

            return transaction

        case .userCancelled, .pending:
            return nil

        @unknown default:
            return nil
        }
    }

    // MARK: - Restore Purchases

    func restorePurchases() async {
        do {
            try await AppStore.sync()
            await updateCustomerProductStatus()
        } catch {
            print("Failed to restore purchases: \(error)")
        }
    }

    // MARK: - Check Subscription Status

    func updateCustomerProductStatus() async {
        var purchasedSubscriptions: [Product] = []

        // Check current entitlements
        for await result in Transaction.currentEntitlements {
            do {
                let transaction = try checkVerified(result)

                if let product = products.first(where: { $0.id == transaction.productID }) {
                    purchasedSubscriptions.append(product)
                }
            } catch {
                print("Transaction verification failed: \(error)")
            }
        }

        self.purchasedSubscriptions = purchasedSubscriptions

        // Update subscription group status
        await updateSubscriptionGroupStatus()
    }

    private func updateSubscriptionGroupStatus() async {
        guard let product = products.first(where: { $0.type == .autoRenewable }) else {
            return
        }

        guard let statuses = try? await product.subscription?.status else {
            return
        }

        var highestStatus: RenewalState?

        for status in statuses {
            switch status.state {
            case .subscribed:
                highestStatus = .subscribed

            case .expired:
                if highestStatus == nil {
                    highestStatus = .expired
                }

            case .inGracePeriod:
                highestStatus = .inGracePeriod

            case .inBillingRetryPeriod:
                if highestStatus == nil || highestStatus == .expired {
                    highestStatus = .inBillingRetryPeriod
                }

            case .revoked:
                if highestStatus == nil {
                    highestStatus = .revoked
                }

            default:
                break
            }
        }

        self.subscriptionGroupStatus = highestStatus
    }

    // MARK: - Listen for Transactions

    private func listenForTransactions() -> Task<Void, Error> {
        return Task.detached {
            for await result in Transaction.updates {
                do {
                    let transaction = try self.checkVerified(result)

                    await self.updateCustomerProductStatus()

                    await transaction.finish()
                } catch {
                    print("Transaction failed verification: \(error)")
                }
            }
        }
    }

    // MARK: - Verification

    private func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .unverified:
            throw StoreError.failedVerification
        case .verified(let safe):
            return safe
        }
    }

    // MARK: - Check Active Subscription

    func hasActiveSubscription() -> Bool {
        return !purchasedSubscriptions.isEmpty || subscriptionGroupStatus == .subscribed
    }

    // MARK: - Get Product by ID

    func product(for productID: ProductID) -> Product? {
        return products.first(where: { $0.id == productID.rawValue })
    }
}

// MARK: - Store Error

enum StoreError: Error {
    case failedVerification
}

// MARK: - Product Extension

extension Product {
    var localizedPrice: String {
        return self.displayPrice
    }

    var subscriptionPeriodString: String {
        guard let subscription = self.subscription else {
            return "Lifetime"
        }

        let unit = subscription.subscriptionPeriod.unit
        let value = subscription.subscriptionPeriod.value

        switch unit {
        case .day:
            return value == 1 ? "day" : "\(value) days"
        case .week:
            return value == 1 ? "week" : "\(value) weeks"
        case .month:
            return value == 1 ? "month" : "\(value) months"
        case .year:
            return value == 1 ? "year" : "\(value) years"
        @unknown default:
            return ""
        }
    }

    var isSubscription: Bool {
        return type == .autoRenewable || type == .nonRenewable
    }
}
