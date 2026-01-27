import Foundation
import SwiftUI

/// Language options for the app
enum AppLanguage: String, CaseIterable {
    case english = "en"
    case vietnamese = "vi"

    var displayName: String {
        switch self {
        case .english: return "English"
        case .vietnamese: return "Tiếng Việt"
        }
    }

    var flag: String {
        switch self {
        case .english: return "🇺🇸"
        case .vietnamese: return "🇻🇳"
        }
    }
}

/// Localization manager for bilingual support
class LocalizationManager: ObservableObject {
    static let shared = LocalizationManager()

    @Published var currentLanguage: AppLanguage {
        didSet {
            UserDefaults.standard.set(currentLanguage.rawValue, forKey: "appLanguage")
        }
    }

    private init() {
        let savedLanguage = UserDefaults.standard.string(forKey: "appLanguage") ?? "vi"
        self.currentLanguage = AppLanguage(rawValue: savedLanguage) ?? .vietnamese
    }

    func localized(_ key: LocalizedKey) -> String {
        return key.localized(for: currentLanguage)
    }
}

/// All localized strings
enum LocalizedKey {
    // Tabs
    case tabLearn
    case tabLeaderboard
    case tabAchievements
    case tabProfile

    // Home
    case greeting
    case continueStudy
    case yourLessons
    case totalXP
    case level
    case currentStreak
    case longestStreak
    case progressToLevel

    // Lesson
    case question
    case checkAnswer
    case continueButton
    case finish
    case correct
    case incorrect
    case listenQuestion
    case listenCorrectAnswer
    case completed
    case excellent
    case score
    case xpEarned

    // Profile
    case profile
    case settings
    case privacyPolicy
    case termsOfService
    case logout
    case premium
    case upgradePremium
    case unlockAllFeatures

    // Achievements
    case achievements
    case achievementsUnlocked
    case progress
    case all
    case newAchievement
    case awesome

    // Onboarding
    case welcomeTitle
    case welcomeDescription
    case gameLearningTitle
    case gameLearningDescription
    case pronunciationTitle
    case pronunciationDescription
    case progressTitle
    case progressDescription
    case safetyTitle
    case safetyDescription
    case skip
    case continueOnboarding
    case getStarted
    case howOldAreYou
    case helpUsCustomize

    // Parent Gate
    case parentGate
    case parentGateDescription
    case enterAnswer
    case confirm
    case incorrectAnswer
    case tooManyAttempts
    case coppaNotice

    // Premium
    case startFreeTrial
    case restorePurchases
    case autoRenew
    case unlimitedLessons
    case aiPronunciation
    case detailedProgress
    case offlineLessons
    case noAds
    case certificates

    func localized(for language: AppLanguage) -> String {
        switch language {
        case .english:
            return englishTranslation
        case .vietnamese:
            return vietnameseTranslation
        }
    }

    private var englishTranslation: String {
        switch self {
        // Tabs
        case .tabLearn: return "Learn"
        case .tabLeaderboard: return "Leaderboard"
        case .tabAchievements: return "Achievements"
        case .tabProfile: return "Profile"

        // Home
        case .greeting: return "Hello"
        case .continueStudy: return "Let's continue learning!"
        case .yourLessons: return "Your Lessons"
        case .totalXP: return "Total XP"
        case .level: return "Level"
        case .currentStreak: return "Current Streak"
        case .longestStreak: return "Longest Streak"
        case .progressToLevel: return "Progress to Level"

        // Lesson
        case .question: return "Question"
        case .checkAnswer: return "Check"
        case .continueButton: return "Continue"
        case .finish: return "Finish"
        case .correct: return "Correct!"
        case .incorrect: return "Incorrect. Answer:"
        case .listenQuestion: return "Listen to Question"
        case .listenCorrectAnswer: return "Listen to Answer"
        case .completed: return "Completed!"
        case .excellent: return "Excellent!"
        case .score: return "Score"
        case .xpEarned: return "XP"

        // Profile
        case .profile: return "Profile"
        case .settings: return "Settings"
        case .privacyPolicy: return "Privacy Policy"
        case .termsOfService: return "Terms of Service"
        case .logout: return "Logout"
        case .premium: return "Premium"
        case .upgradePremium: return "Upgrade to Premium"
        case .unlockAllFeatures: return "Unlock all features"

        // Achievements
        case .achievements: return "Achievements"
        case .achievementsUnlocked: return "Achievements Unlocked"
        case .progress: return "Progress"
        case .all: return "All"
        case .newAchievement: return "New Achievement!"
        case .awesome: return "Awesome!"

        // Onboarding
        case .welcomeTitle: return "Welcome to\nEnglish Learning App!"
        case .welcomeDescription: return "Fun and effective English learning for kids ages 6-12"
        case .gameLearningTitle: return "Learn Through Games"
        case .gameLearningDescription: return "40+ interactive lessons with variety of questions, proper pronunciation, and exciting rewards"
        case .pronunciationTitle: return "Practice Pronunciation"
        case .pronunciationDescription: return "Listen and learn proper pronunciation with advanced Text-to-Speech technology"
        case .progressTitle: return "Track Progress"
        case .progressDescription: return "Earn XP, level up, and maintain daily streaks to become an English master"
        case .safetyTitle: return "Safe for Kids"
        case .safetyDescription: return "COPPA compliant with Parent Gate and privacy protection for children"
        case .skip: return "Skip"
        case .continueOnboarding: return "Continue"
        case .getStarted: return "Get Started"
        case .howOldAreYou: return "How old are you?"
        case .helpUsCustomize: return "Help us customize content for you"

        // Parent Gate
        case .parentGate: return "Parent Gate"
        case .parentGateDescription: return "To protect children, please solve this problem:"
        case .enterAnswer: return "Enter answer"
        case .confirm: return "Confirm"
        case .incorrectAnswer: return "Incorrect answer. Please try again."
        case .tooManyAttempts: return "Too many attempts. Please try again later."
        case .coppaNotice: return "This is a child protection gate per COPPA regulations"

        // Premium
        case .startFreeTrial: return "Start 7-Day Free Trial"
        case .restorePurchases: return "Restore Purchases"
        case .autoRenew: return "Auto-renews. Cancel anytime."
        case .unlimitedLessons: return "Unlimited Lessons"
        case .aiPronunciation: return "AI Pronunciation Practice"
        case .detailedProgress: return "Detailed Progress Tracking"
        case .offlineLessons: return "Download Lessons for Offline"
        case .noAds: return "No Ads"
        case .certificates: return "Completion Certificates"
        }
    }

    private var vietnameseTranslation: String {
        switch self {
        // Tabs
        case .tabLearn: return "Học"
        case .tabLeaderboard: return "Xếp hạng"
        case .tabAchievements: return "Thành tích"
        case .tabProfile: return "Hồ sơ"

        // Home
        case .greeting: return "Xin chào"
        case .continueStudy: return "Tiếp tục học nào!"
        case .yourLessons: return "Bài học của bạn"
        case .totalXP: return "Tổng XP"
        case .level: return "Cấp độ"
        case .currentStreak: return "Streak hiện tại"
        case .longestStreak: return "Streak cao nhất"
        case .progressToLevel: return "Tiến độ lên cấp"

        // Lesson
        case .question: return "Câu"
        case .checkAnswer: return "Kiểm tra"
        case .continueButton: return "Tiếp tục"
        case .finish: return "Hoàn thành"
        case .correct: return "Chính xác!"
        case .incorrect: return "Chưa đúng. Đáp án:"
        case .listenQuestion: return "Nghe câu hỏi"
        case .listenCorrectAnswer: return "Nghe đáp án đúng"
        case .completed: return "Hoàn thành!"
        case .excellent: return "Xuất sắc!"
        case .score: return "Điểm số"
        case .xpEarned: return "XP"

        // Profile
        case .profile: return "Hồ sơ"
        case .settings: return "Cài đặt"
        case .privacyPolicy: return "Chính Sách Bảo Mật"
        case .termsOfService: return "Điều Khoản Dịch Vụ"
        case .logout: return "Đăng xuất"
        case .premium: return "Premium"
        case .upgradePremium: return "Nâng cấp Premium"
        case .unlockAllFeatures: return "Mở khóa tất cả tính năng"

        // Achievements
        case .achievements: return "Thành tích"
        case .achievementsUnlocked: return "Thành tích đã mở khóa"
        case .progress: return "Tiến độ"
        case .all: return "Tất cả"
        case .newAchievement: return "Thành tích mới!"
        case .awesome: return "Tuyệt vời!"

        // Onboarding
        case .welcomeTitle: return "Chào mừng đến với\nỨng dụng Học Tiếng Anh!"
        case .welcomeDescription: return "Học tiếng Anh vui vẻ và hiệu quả dành cho trẻ em từ 6-12 tuổi"
        case .gameLearningTitle: return "Học qua trò chơi"
        case .gameLearningDescription: return "40+ bài học tương tác với câu hỏi đa dạng, phát âm chuẩn và điểm thưởng hấp dẫn"
        case .pronunciationTitle: return "Luyện phát âm"
        case .pronunciationDescription: return "Nghe và học phát âm chuẩn với công nghệ Text-to-Speech tiên tiến"
        case .progressTitle: return "Theo dõi tiến độ"
        case .progressDescription: return "Nhận XP, thăng cấp, và duy trì streak mỗi ngày để trở thành cao thủ tiếng Anh"
        case .safetyTitle: return "An toàn cho trẻ em"
        case .safetyDescription: return "Tuân thủ COPPA với Parent Gate và bảo vệ quyền riêng tư của trẻ"
        case .skip: return "Bỏ qua"
        case .continueOnboarding: return "Tiếp tục"
        case .getStarted: return "Bắt đầu học"
        case .howOldAreYou: return "Bạn bao nhiêu tuổi?"
        case .helpUsCustomize: return "Giúp chúng tôi tùy chỉnh nội dung phù hợp"

        // Parent Gate
        case .parentGate: return "Cổng Dành Cho Phụ Huynh"
        case .parentGateDescription: return "Để bảo vệ trẻ em, vui lòng giải bài toán sau:"
        case .enterAnswer: return "Nhập đáp án"
        case .confirm: return "Xác Nhận"
        case .incorrectAnswer: return "Đáp án không đúng. Vui lòng thử lại."
        case .tooManyAttempts: return "Quá nhiều lần thử. Vui lòng thử lại sau."
        case .coppaNotice: return "Đây là cổng bảo vệ trẻ em theo quy định COPPA"

        // Premium
        case .startFreeTrial: return "Bắt đầu dùng thử miễn phí 7 ngày"
        case .restorePurchases: return "Khôi phục gói đã mua"
        case .autoRenew: return "Tự động gia hạn. Hủy bất kỳ lúc nào."
        case .unlimitedLessons: return "Không giới hạn bài học"
        case .aiPronunciation: return "Luyện phát âm với AI"
        case .detailedProgress: return "Theo dõi tiến độ chi tiết"
        case .offlineLessons: return "Tải bài học offline"
        case .noAds: return "Không quảng cáo"
        case .certificates: return "Chứng chỉ hoàn thành"
        }
    }
}
