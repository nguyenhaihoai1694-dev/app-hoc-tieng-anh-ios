import SwiftUI

struct LessonView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var progressManager: UserProgressManager

    let lesson: Lesson

    @State private var currentQuestionIndex = 0
    @State private var selectedAnswer = ""
    @State private var userAnswer = ""
    @State private var showResult = false
    @State private var isCorrect = false
    @State private var correctAnswers = 0
    @State private var showCompletion = false

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Progress Bar
                ProgressView(value: Double(currentQuestionIndex), total: Double(lesson.questions.count))
                    .tint(.green)
                    .padding()

                // Question Counter
                Text("Câu \(currentQuestionIndex + 1) / \(lesson.questions.count)")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.bottom)

                ScrollView {
                    VStack(spacing: 30) {
                        if currentQuestionIndex < lesson.questions.count {
                            let question = lesson.questions[currentQuestionIndex]

                            // Question
                            Text(question.prompt)
                                .font(.title2)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.center)
                                .padding()

                            // Answer Options
                            if question.type == .multipleChoice {
                                ForEach(question.options ?? [], id: \.self) { option in
                                    OptionButton(
                                        text: option,
                                        isSelected: selectedAnswer == option,
                                        isCorrect: showResult && option == question.correctAnswer,
                                        isWrong: showResult && selectedAnswer == option && option != question.correctAnswer
                                    ) {
                                        if !showResult {
                                            selectedAnswer = option
                                        }
                                    }
                                }
                            } else {
                                // Text Input for other types
                                TextField("Nhập câu trả lời...", text: $userAnswer)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding()
                                    .disabled(showResult)
                            }

                            // Result Message
                            if showResult {
                                HStack {
                                    Image(systemName: isCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
                                        .foregroundColor(isCorrect ? .green : .red)
                                        .font(.title)

                                    Text(isCorrect ? "Chính xác!" : "Chưa đúng. Đáp án: \(question.correctAnswer)")
                                        .font(.headline)
                                        .foregroundColor(isCorrect ? .green : .red)
                                }
                                .padding()
                                .background(isCorrect ? Color.green.opacity(0.1) : Color.red.opacity(0.1))
                                .cornerRadius(10)
                            }
                        }
                    }
                    .padding()
                }

                // Action Button
                Button(action: handleAction) {
                    Text(buttonTitle)
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(buttonColor)
                        .cornerRadius(15)
                }
                .padding()
                .disabled(!canProceed)
            }
            .navigationTitle(lesson.title)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button("Đóng") {
                presentationMode.wrappedValue.dismiss()
            })
            .sheet(isPresented: $showCompletion) {
                CompletionView(
                    score: score,
                    xpEarned: lesson.xpReward,
                    lessonTitle: lesson.title
                ) {
                    progressManager.completeLesson(
                        lesson.id,
                        score: score,
                        xpReward: lesson.xpReward,
                        authViewModel: authViewModel
                    )
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }

    private var buttonTitle: String {
        if showResult {
            return currentQuestionIndex < lesson.questions.count - 1 ? "Tiếp tục" : "Hoàn thành"
        } else {
            return "Kiểm tra"
        }
    }

    private var buttonColor: Color {
        canProceed ? .blue : .gray
    }

    private var canProceed: Bool {
        if showResult {
            return true
        }
        let question = lesson.questions[currentQuestionIndex]
        return question.type == .multipleChoice ? !selectedAnswer.isEmpty : !userAnswer.isEmpty
    }

    private var score: Int {
        return Int(Double(correctAnswers) / Double(lesson.questions.count) * 100)
    }

    private func handleAction() {
        if showResult {
            // Move to next question or complete
            if currentQuestionIndex < lesson.questions.count - 1 {
                currentQuestionIndex += 1
                resetQuestion()
            } else {
                showCompletion = true
            }
        } else {
            // Check answer
            checkAnswer()
        }
    }

    private func checkAnswer() {
        let question = lesson.questions[currentQuestionIndex]
        let answer = question.type == .multipleChoice ? selectedAnswer : userAnswer

        isCorrect = answer.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) ==
                    question.correctAnswer.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)

        if isCorrect {
            correctAnswers += 1
        }

        showResult = true
    }

    private func resetQuestion() {
        selectedAnswer = ""
        userAnswer = ""
        showResult = false
        isCorrect = false
    }
}

struct OptionButton: View {
    let text: String
    let isSelected: Bool
    let isCorrect: Bool
    let isWrong: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Text(text)
                    .foregroundColor(textColor)
                    .multilineTextAlignment(.leading)

                Spacer()

                if isCorrect {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                } else if isWrong {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.red)
                }
            }
            .padding()
            .background(backgroundColor)
            .cornerRadius(15)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(borderColor, lineWidth: 2)
            )
        }
        .padding(.horizontal)
    }

    private var backgroundColor: Color {
        if isCorrect {
            return Color.green.opacity(0.1)
        } else if isWrong {
            return Color.red.opacity(0.1)
        } else if isSelected {
            return Color.blue.opacity(0.1)
        } else {
            return Color.white
        }
    }

    private var borderColor: Color {
        if isCorrect {
            return .green
        } else if isWrong {
            return .red
        } else if isSelected {
            return .blue
        } else {
            return .gray.opacity(0.3)
        }
    }

    private var textColor: Color {
        if isCorrect {
            return .green
        } else if isWrong {
            return .red
        } else {
            return .primary
        }
    }
}

struct CompletionView: View {
    let score: Int
    let xpEarned: Int
    let lessonTitle: String
    let onDismiss: () -> Void

    var body: some View {
        VStack(spacing: 30) {
            Spacer()

            // Trophy Icon
            Image(systemName: score >= 80 ? "trophy.fill" : "star.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(score >= 80 ? .yellow : .orange)

            // Title
            Text(score >= 80 ? "Xuất sắc!" : "Hoàn thành!")
                .font(.system(size: 36, weight: .bold))

            // Score
            Text("Điểm số: \(score)%")
                .font(.title)
                .foregroundColor(.primary)

            // XP Earned
            HStack {
                Image(systemName: "star.fill")
                    .foregroundColor(.orange)
                Text("+\(xpEarned) XP")
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            .padding()
            .background(Color.orange.opacity(0.1))
            .cornerRadius(15)

            Spacer()

            // Continue Button
            Button(action: onDismiss) {
                Text("Tiếp tục")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(15)
            }
            .padding(.horizontal, 40)
            .padding(.bottom, 40)
        }
        .background(Color(.systemGroupedBackground))
    }
}

struct LessonView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleLesson = Lesson(
            title: "Greetings",
            description: "Learn basic greetings",
            level: 1,
            xpReward: 10,
            questions: [
                Question(
                    type: .multipleChoice,
                    prompt: "How do you say 'Hello' in English?",
                    correctAnswer: "Hello",
                    options: ["Hello", "Goodbye", "Thanks", "Sorry"]
                )
            ]
        )

        return LessonView(lesson: sampleLesson)
            .environmentObject(AuthViewModel())
            .environmentObject(UserProgressManager())
    }
}
