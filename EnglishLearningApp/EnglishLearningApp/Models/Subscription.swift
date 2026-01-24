import Foundation

enum SubscriptionPlan: String, CaseIterable, Codable {
    case free = "free"
    case monthly = "com.englishlearning.premium.monthly"
    case yearly = "com.englishlearning.premium.yearly"

    var displayName: String {
        switch self {
        case .free: return "Miễn phí"
        case .monthly: return "Premium - Tháng"
        case .yearly: return "Premium - Năm"
        }
    }

    var price: String {
        switch self {
        case .free: return "$0"
        case .monthly: return "$9.99"
        case .yearly: return "$79.99"
        }
    }

    var description: String {
        switch self {
        case .free: return "Học cơ bản miễn phí"
        case .monthly: return "Truy cập không giới hạn tất cả bài học"
        case .yearly: return "Tiết kiệm 33% - Truy cập không giới hạn"
        }
    }

    var features: [String] {
        switch self {
        case .free:
            return [
                "Bài học cơ bản",
                "Giới hạn 5 bài/ngày",
                "Quảng cáo"
            ]
        case .monthly, .yearly:
            return [
                "Không giới hạn bài học",
                "Không quảng cáo",
                "Tất cả bài học Premium",
                "Theo dõi tiến độ chi tiết",
                "Luyện phát âm với AI",
                "Tải bài học offline"
            ]
        }
    }
}

struct SubscriptionStatus: Codable {
    var currentPlan: SubscriptionPlan
    var isActive: Bool
    var expiryDate: Date?
    var autoRenew: Bool

    init(currentPlan: SubscriptionPlan = .free) {
        self.currentPlan = currentPlan
        self.isActive = currentPlan != .free
        self.expiryDate = nil
        self.autoRenew = false
    }
}
