import Foundation

struct Lesson: Codable, Identifiable {
    let id: UUID
    let title: String
    let description: String
    let level: Int
    let xpReward: Int
    let questions: [Question]
    let isPremium: Bool
    var isCompleted: Bool
    var bestScore: Int?

    init(id: UUID = UUID(), title: String, description: String, level: Int, xpReward: Int, questions: [Question], isPremium: Bool = false) {
        self.id = id
        self.title = title
        self.description = description
        self.level = level
        self.xpReward = xpReward
        self.questions = questions
        self.isPremium = isPremium
        self.isCompleted = false
        self.bestScore = nil
    }
}

struct Question: Codable, Identifiable {
    let id: UUID
    let type: QuestionType
    let prompt: String
    let correctAnswer: String
    let options: [String]?
    let imageURL: String?

    init(id: UUID = UUID(), type: QuestionType, prompt: String, correctAnswer: String, options: [String]? = nil, imageURL: String? = nil) {
        self.id = id
        self.type = type
        self.prompt = prompt
        self.correctAnswer = correctAnswer
        self.options = options
        self.imageURL = imageURL
    }
}

enum QuestionType: String, Codable {
    case multipleChoice = "multiple_choice"
    case fillInBlank = "fill_in_blank"
    case translation = "translation"
    case listening = "listening"
    case speaking = "speaking"
}
