import Foundation

struct Lesson: Codable, Identifiable {
    let id: UUID
    let title: String
    let description: String
    let level: Int
    let xpReward: Int
    let vocabularyItems: [VocabularyItem]
    let questions: [Question]
    let isPremium: Bool
    var isCompleted: Bool
    var bestScore: Int?
    var isLocked: Bool  // New property for sequential progression

    init(id: UUID = UUID(), title: String, description: String, level: Int, xpReward: Int, vocabularyItems: [VocabularyItem] = [], questions: [Question], isPremium: Bool = false) {
        self.id = id
        self.title = title
        self.description = description
        self.level = level
        self.xpReward = xpReward
        self.vocabularyItems = vocabularyItems
        self.questions = questions
        self.isPremium = isPremium
        self.isCompleted = false
        self.bestScore = nil
        self.isLocked = false  // Will be calculated based on previous lessons
    }
}

struct VocabularyItem: Codable, Identifiable {
    let id: UUID
    let english: String
    let vietnamese: String
    let example: String

    init(id: UUID = UUID(), english: String, vietnamese: String, example: String) {
        self.id = id
        self.english = english
        self.vietnamese = vietnamese
        self.example = example
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
