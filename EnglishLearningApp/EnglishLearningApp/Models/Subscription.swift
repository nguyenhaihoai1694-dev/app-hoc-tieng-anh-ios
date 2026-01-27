import Foundation

enum SubscriptionPlan: String, CaseIterable, Codable {
    case free = "free"
    case weekly = "com.englishlearning.app.weekly"
    case monthly = "com.englishlearning.app.monthly"
    case yearly = "com.englishlearning.app.yearly"
    case family = "com.englishlearning.app.family"
    case lifetime = "com.englishlearning.app.lifetime"

    var displayName: String {
        switch self {
        case .free: return "Miễn phí"
        case .weekly: return "Premium - Tuần"
        case .monthly: return "Premium - Tháng"
        case .yearly: return "Premium - Năm"
        case .family: return "Gói Gia Đình"
        case .lifetime: return "Premium Trọn Đời"
        }
    }

    var price: String {
        switch self {
        case .free: return "$0"
        case .weekly: return "$0.99"
        case .monthly: return "$1.99"
        case .yearly: return "$9.99"
        case .family: return "$12.99"
        case .lifetime: return "$22.99"
        }
    }

    var description: String {
        switch self {
        case .free: return "Học cơ bản miễn phí"
        case .weekly: return "Dùng thử 1 tuần - Hoàn hảo để bắt đầu"
        case .monthly: return "Truy cập không giới hạn tất cả bài học"
        case .yearly: return "Tiết kiệm 58% - Giá trị tốt nhất!"
        case .family: return "Chia sẻ với tối đa 6 thành viên gia đình"
        case .lifetime: return "Trả 1 lần, dùng suốt đời - Không cần đăng ký!"
        }
    }

    var badge: String? {
        switch self {
        case .yearly: return "Phổ biến nhất"
        case .lifetime: return "Giá trị tốt nhất"
        default: return nil
        }
    }

    var features: [String] {
        switch self {
        case .free:
            return [
                "Bài học cơ bản",
                "70 trái tim/ngày",
                "Có quảng cáo"
            ]
        case .weekly, .monthly, .yearly:
            return [
                "❤️ Trái tim không giới hạn",
                "🎓 Tất cả 40 bài học Premium",
                "🚫 Không quảng cáo",
                "📊 Theo dõi tiến độ chi tiết",
                "🏆 Achievements đặc biệt",
                "🎯 Luyện phát âm với TTS"
            ]
        case .family:
            return [
                "👨‍👩‍👧‍👦 Chia sẻ với 6 người",
                "❤️ Trái tim không giới hạn",
                "🎓 Tất cả 40 bài học Premium",
                "🚫 Không quảng cáo",
                "📊 Theo dõi tiến độ từng người",
                "💰 Tiết kiệm tới 50%"
            ]
        case .lifetime:
            return [
                "♾️ Trả 1 lần, dùng mãi mãi",
                "❤️ Trái tim không giới hạn",
                "🎓 Tất cả bài học (hiện tại + tương lai)",
                "🚫 Không quảng cáo",
                "👑 Status VIP đặc biệt",
                "🎁 Tất cả updates miễn phí"
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
