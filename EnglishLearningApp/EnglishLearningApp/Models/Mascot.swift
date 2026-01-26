import SwiftUI

/// Mascot states representing different emotions and actions
enum MascotState {
    case happy
    case excited
    case celebrating
    case thinking
    case encouraging
    case sleeping
    case waving

    var emoji: String {
        switch self {
        case .happy:
            return "😊"
        case .excited:
            return "🤩"
        case .celebrating:
            return "🎉"
        case .thinking:
            return "🤔"
        case .encouraging:
            return "💪"
        case .sleeping:
            return "😴"
        case .waving:
            return "👋"
        }
    }

    var message: String {
        switch self {
        case .happy:
            return "Bạn đang làm tốt lắm!"
        case .excited:
            return "Wowww! Tuyệt vời quá!"
        case .celebrating:
            return "Xuất sắc! Bạn thật giỏi!"
        case .thinking:
            return "Hmmm... Suy nghĩ kỹ nhé!"
        case .encouraging:
            return "Cố lên! Bạn làm được!"
        case .sleeping:
            return "Nghỉ ngơi một chút nhé..."
        case .waving:
            return "Xin chào! Bắt đầu học nào!"
        }
    }

    var color: Color {
        switch self {
        case .happy:
            return .yellow
        case .excited:
            return .orange
        case .celebrating:
            return .purple
        case .thinking:
            return .blue
        case .encouraging:
            return .green
        case .sleeping:
            return .gray
        case .waving:
            return .pink
        }
    }
}

/// Mascot character for the app
struct Mascot {
    static let name = "Bee" // English Bee mascot

    /// Get appropriate mascot state based on context
    static func stateFor(score: Int) -> MascotState {
        switch score {
        case 90...100:
            return .celebrating
        case 70..<90:
            return .excited
        case 50..<70:
            return .happy
        default:
            return .encouraging
        }
    }

    /// Get mascot state for lesson context
    static func stateForLesson(questionNumber: Int, totalQuestions: Int, isCorrect: Bool?) -> MascotState {
        if let isCorrect = isCorrect {
            return isCorrect ? .happy : .encouraging
        } else if questionNumber == 1 {
            return .waving
        } else if questionNumber == totalQuestions {
            return .excited
        } else {
            return .thinking
        }
    }
}
