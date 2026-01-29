import Foundation

enum SubscriptionPlan: String, CaseIterable, Codable {
    case free = "free"
    case week1 = "com.hoai.englishkidsapp.week1"       // $1
    case month1 = "com.hoai.englishkidsapp.month1"     // $3
    case month2 = "com.hoai.englishkidsapp.month2"     // $5
    case month3 = "com.hoai.englishkidsapp.month3"     // $10
    case month6 = "com.hoai.englishkidsapp.month6"     // $20
    case year1 = "com.hoai.englishkidsapp.year1"       // $50
    case year2 = "com.hoai.englishkidsapp.year2"       // $100
    case lifetime = "com.hoai.englishkidsapp.lifetime" // $150

    var displayName: String {
        switch self {
        case .free: return "Miễn phí"
        case .week1: return "Premium 1 Tuần"
        case .month1: return "Premium 1 Tháng"
        case .month2: return "Premium 2 Tháng"
        case .month3: return "Premium 3 Tháng"
        case .month6: return "Premium 6 Tháng"
        case .year1: return "Premium 1 Năm"
        case .year2: return "Premium 2 Năm"
        case .lifetime: return "Premium Trọn Đời"
        }
    }

    var price: String {
        switch self {
        case .free: return "$0"
        case .week1: return "$1"
        case .month1: return "$3"
        case .month2: return "$5"
        case .month3: return "$10"
        case .month6: return "$20"
        case .year1: return "$50"
        case .year2: return "$100"
        case .lifetime: return "$150"
        }
    }

    var description: String {
        switch self {
        case .free: return "Học cơ bản miễn phí"
        case .week1: return "Dùng thử Premium 1 tuần"
        case .month1: return "Premium trong 1 tháng"
        case .month2: return "Premium trong 2 tháng - Tiết kiệm 17%"
        case .month3: return "Premium trong 3 tháng - Tiết kiệm 33%"
        case .month6: return "Premium trong 6 tháng - Tiết kiệm 44%"
        case .year1: return "Premium trong 1 năm - Tiết kiệm 58%"
        case .year2: return "Premium trong 2 năm - Tiết kiệm 72%"
        case .lifetime: return "Trả 1 lần, dùng suốt đời - Giá trị tuyệt vời!"
        }
    }

    var badge: String? {
        switch self {
        case .month1: return "Phổ biến nhất"
        case .year1: return "Tiết kiệm nhất"
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
        case .week1, .month1, .month2, .month3, .month6, .year1, .year2:
            return [
                "❤️ Trái tim không giới hạn",
                "🎓 Tất cả 40 bài học Premium",
                "🚫 Không quảng cáo",
                "📊 Theo dõi tiến độ chi tiết",
                "🏆 Achievements đặc biệt",
                "🎯 Luyện phát âm với TTS"
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
