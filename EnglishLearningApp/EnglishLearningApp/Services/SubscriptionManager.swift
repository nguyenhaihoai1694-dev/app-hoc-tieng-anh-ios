import Foundation
import StoreKit
import Combine

class SubscriptionManager: NSObject, ObservableObject {
    @Published var subscriptionStatus = SubscriptionStatus()
    @Published var availableProducts: [SKProduct] = []
    @Published var isPurchasing = false
    @Published var purchaseError: String?

    private var productsRequest: SKProductsRequest?
    private var purchaseCompletion: ((Bool, Error?) -> Void)?

    override init() {
        super.init()
        SKPaymentQueue.default().add(self)
        loadSubscriptionStatus()
        fetchProducts()
    }

    deinit {
        SKPaymentQueue.default().remove(self)
    }

    // MARK: - Fetch Products
    func fetchProducts() {
        let productIdentifiers: Set<String> = [
            SubscriptionPlan.monthly.rawValue,
            SubscriptionPlan.yearly.rawValue
        ]

        productsRequest = SKProductsRequest(productIdentifiers: productIdentifiers)
        productsRequest?.delegate = self
        productsRequest?.start()
    }

    // MARK: - Purchase
    func purchase(_ plan: SubscriptionPlan, completion: @escaping (Bool, Error?) -> Void) {
        guard plan != .free else {
            completion(false, NSError(domain: "SubscriptionManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Cannot purchase free plan"]))
            return
        }

        guard let product = availableProducts.first(where: { $0.productIdentifier == plan.rawValue }) else {
            completion(false, NSError(domain: "SubscriptionManager", code: -2, userInfo: [NSLocalizedDescriptionKey: "Product not found"]))
            return
        }

        isPurchasing = true
        purchaseCompletion = completion

        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
    }

    // MARK: - Restore Purchases
    func restorePurchases(completion: @escaping (Bool, Error?) -> Void) {
        purchaseCompletion = completion
        SKPaymentQueue.default().restoreCompletedTransactions()
    }

    // MARK: - Subscription Status
    func hasActiveSubscription() -> Bool {
        guard let expiryDate = subscriptionStatus.expiryDate else {
            return subscriptionStatus.currentPlan != .free
        }
        return Date() < expiryDate
    }

    func updateSubscriptionStatus(plan: SubscriptionPlan, expiryDate: Date? = nil) {
        subscriptionStatus.currentPlan = plan
        subscriptionStatus.isActive = plan != .free
        subscriptionStatus.expiryDate = expiryDate
        subscriptionStatus.autoRenew = true
        saveSubscriptionStatus()
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

// MARK: - SKProductsRequestDelegate
extension SubscriptionManager: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        DispatchQueue.main.async {
            self.availableProducts = response.products.sorted { $0.price.decimalValue < $1.price.decimalValue }
        }
    }

    func request(_ request: SKRequest, didFailWithError error: Error) {
        DispatchQueue.main.async {
            self.purchaseError = error.localizedDescription
        }
    }
}

// MARK: - SKPaymentTransactionObserver
extension SubscriptionManager: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchased:
                handlePurchased(transaction)
            case .restored:
                handleRestored(transaction)
            case .failed:
                handleFailed(transaction)
            case .deferred, .purchasing:
                break
            @unknown default:
                break
            }
        }
    }

    private func handlePurchased(_ transaction: SKPaymentTransaction) {
        let productId = transaction.payment.productIdentifier

        // Grant subscription
        if let plan = SubscriptionPlan(rawValue: productId) {
            let expiryDate: Date?
            if plan == .monthly {
                expiryDate = Calendar.current.date(byAdding: .month, value: 1, to: Date())
            } else {
                expiryDate = Calendar.current.date(byAdding: .year, value: 1, to: Date())
            }
            updateSubscriptionStatus(plan: plan, expiryDate: expiryDate)
        }

        SKPaymentQueue.default().finishTransaction(transaction)

        DispatchQueue.main.async {
            self.isPurchasing = false
            self.purchaseCompletion?(true, nil)
            self.purchaseCompletion = nil
        }
    }

    private func handleRestored(_ transaction: SKPaymentTransaction) {
        handlePurchased(transaction)
    }

    private func handleFailed(_ transaction: SKPaymentTransaction) {
        SKPaymentQueue.default().finishTransaction(transaction)

        DispatchQueue.main.async {
            self.isPurchasing = false
            self.purchaseError = transaction.error?.localizedDescription
            self.purchaseCompletion?(false, transaction.error)
            self.purchaseCompletion = nil
        }
    }
}
