import SwiftUI

struct LessonView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var progressManager: UserProgressManager
    @EnvironmentObject var subscriptionManager: SubscriptionManager
    @StateObject private var ttsService = TextToSpeechService.shared
    @StateObject private var heartManager = HeartManager.shared
    private let soundService = SoundEffectService.shared

    let lesson: Lesson

    @State private var currentQuestionIndex = 0
    @State private var selectedAnswer = ""
    @State private var userAnswer = ""
    @State private var showResult = false
    @State private var isCorrect = false
    @State private var correctAnswers = 0
    @State private var showCompletion = false
    @State private var showConfetti = false
    @State private var mascotState: MascotState = .thinking
    @State private var showOutOfHearts = false
    @State private var quizLives = 3  // 3 lives per quiz attempt
    @State private var showQuizFailed = false
    @State private var shuffledOptions: [String] = []  // Shuffled options for current question

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Progress Bar
                ProgressView(value: Double(currentQuestionIndex), total: Double(lesson.questions.count))
                    .tint(.green)
                    .padding()
                    .accessibilityLabel("Tiến độ bài học")
                    .accessibilityValue("Đang ở câu \(currentQuestionIndex + 1) trong tổng số \(lesson.questions.count) câu")

                // Question Counter and Lives
                HStack {
                    Text("Câu \(currentQuestionIndex + 1) / \(lesson.questions.count)")
                        .font(.system(size: 16))
                        .foregroundColor(.secondary)

                    Spacer()

                    // Quiz Lives (3 hearts per quiz)
                    HStack(spacing: 4) {
                        ForEach(0..<3, id: \.self) { index in
                            Image(systemName: index < quizLives ? "heart.fill" : "heart")
                                .foregroundColor(index < quizLives ? .red : .gray.opacity(0.3))
                                .font(.system(size: 16))
                        }
                    }
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel("Số mạng còn lại")
                    .accessibilityValue("\(quizLives) trên 3 mạng")
                }
                .padding(.horizontal)
                .padding(.bottom, 5)

                // Mascot for encouragement
                CompactMascotView(state: mascotState, size: 70)
                    .padding(.bottom, 10)
                    .accessibilityLabel("Linh vật hướng dẫn")
                    .accessibilityValue(mascotState == .happy ? "Vui vẻ - Bạn làm rất tốt!" : mascotState == .encouraging ? "Động viên - Cố gắng lên!" : "Đang suy nghĩ")

                ScrollView {
                    VStack(spacing: 30) {
                        if currentQuestionIndex < lesson.questions.count {
                            let question = lesson.questions[currentQuestionIndex]

                            // Question with Speaker Button
                            VStack(spacing: 15) {
                                Text(question.prompt)
                                    .font(.system(size: 28, weight: .semibold))
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal)
                                    .accessibilityLabel("Câu hỏi")
                                    .accessibilityValue(question.prompt)

                                // Speaker Button
                                Button(action: {
                                    ttsService.speak(question.prompt)
                                }) {
                                    HStack {
                                        Image(systemName: ttsService.isSpeaking ? "speaker.wave.3.fill" : "speaker.wave.2.fill")
                                            .font(.title3)
                                        Text("Nghe câu hỏi")
                                            .font(.system(size: 18))
                                    }
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 10)
                                    .background(Color.blue)
                                    .cornerRadius(20)
                                }
                                .accessibilityLabel("Nghe câu hỏi")
                                .accessibilityHint("Nhấn đúp để nghe câu hỏi được đọc to")
                            }
                            .padding(.bottom)

                            // Answer Options
                            if question.type == .multipleChoice {
                                ForEach(shuffledOptions, id: \.self) { option in
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
                                .onAppear {
                                    // Shuffle options only once when question appears
                                    if shuffledOptions.isEmpty {
                                        shuffledOptions = (question.options ?? []).shuffled()
                                    }
                                }
                            } else {
                                // Text Input for other types
                                TextField("Nhập câu trả lời...", text: $userAnswer)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .font(.system(size: 20))
                                    .padding()
                                    .disabled(showResult)
                                    .accessibilityLabel("Ô nhập câu trả lời")
                                    .accessibilityHint("Gõ câu trả lời của bạn vào đây")
                            }

                            // Result Message
                            if showResult {
                                VStack(spacing: 10) {
                                    HStack {
                                        Image(systemName: isCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
                                            .foregroundColor(isCorrect ? .green : .red)
                                            .font(.title)

                                        Text(isCorrect ? "Chính xác!" : "Chưa đúng. Đáp án: \(question.correctAnswer)")
                                            .font(.system(size: 22, weight: .semibold))
                                            .foregroundColor(isCorrect ? .green : .red)
                                    }
                                    .accessibilityElement(children: .combine)
                                    .accessibilityLabel(isCorrect ? "Chính xác! Bạn đã trả lời đúng" : "Chưa đúng. Đáp án đúng là \(question.correctAnswer)")

                                    // Speak correct answer button (if wrong)
                                    if !isCorrect {
                                        Button(action: {
                                            ttsService.speak(question.correctAnswer)
                                        }) {
                                            HStack {
                                                Image(systemName: "speaker.wave.2.fill")
                                                Text("Nghe đáp án đúng")
                                            }
                                            .font(.system(size: 16))
                                            .foregroundColor(.blue)
                                            .padding(.horizontal, 15)
                                            .padding(.vertical, 8)
                                            .background(Color.blue.opacity(0.1))
                                            .cornerRadius(15)
                                        }
                                        .accessibilityLabel("Nghe đáp án đúng")
                                        .accessibilityHint("Nhấn đúp để nghe đáp án đúng được đọc to")
                                    }
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
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(buttonColor)
                        .cornerRadius(15)
                }
                .padding()
                .disabled(!canProceed)
                .accessibilityLabel(buttonTitle)
                .accessibilityHint(showResult ? "Nhấn đúp để tiếp tục" : "Nhấn đúp để kiểm tra câu trả lời")
            }
            .navigationTitle(lesson.title)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: HStack {
                    if !subscriptionManager.hasActiveSubscription() {
                        CompactHeartDisplay()
                    }
                },
                trailing: Button("Đóng") {
                    presentationMode.wrappedValue.dismiss()
                }
            )
            .confetti(isActive: $showConfetti)
            .sheet(isPresented: $showCompletion) {
                let isAlreadyCompleted = authViewModel.currentUser?.completedLessons.contains(lesson.id.uuidString) ?? false
                CompletionView(
                    score: score,
                    xpEarned: isAlreadyCompleted ? 0 : lesson.xpReward,
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
            .fullScreenCover(isPresented: $showOutOfHearts) {
                OutOfHeartsView {
                    showOutOfHearts = false
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .fullScreenCover(isPresented: $showQuizFailed) {
                QuizFailedView(
                    heartsRemaining: heartManager.currentHearts,
                    isPremium: subscriptionManager.hasActiveSubscription()
                ) {
                    // Retry quiz - reset lives
                    quizLives = 3
                    currentQuestionIndex = 0
                    correctAnswers = 0
                    resetQuestion()
                    showQuizFailed = false
                } onExit: {
                    showQuizFailed = false
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .onAppear {
                // Shuffle options for the first question
                if shuffledOptions.isEmpty && !lesson.questions.isEmpty {
                    let firstQuestion = lesson.questions[0]
                    shuffledOptions = (firstQuestion.options ?? []).shuffled()
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
                soundService.playTapSound()
            } else {
                // Celebrate if high score
                if score >= 80 {
                    soundService.playCelebrationSound()
                    showConfetti = true
                }
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

        // Normalize both answers for Vietnamese text comparison
        // This handles "khỏe" vs "khoẻ" and other diacritical variants
        let normalizedAnswer = answer.normalized()
        let normalizedCorrect = question.correctAnswer.normalized()

        isCorrect = normalizedAnswer == normalizedCorrect

        if isCorrect {
            correctAnswers += 1
            soundService.playCorrectSound()
            mascotState = .happy
        } else {
            soundService.playWrongSound()
            mascotState = .encouraging

            // Lose 1 quiz life (not daily hearts yet)
            quizLives -= 1

            // Only deduct 10 daily hearts when all 3 lives are lost
            if quizLives <= 0 {
                // Lost all 3 lives - deduct 10 hearts from daily energy
                if !subscriptionManager.hasActiveSubscription() {
                    heartManager.loseHearts()

                    // Check if out of daily hearts
                    if !heartManager.hasHearts() {
                        // Show out of hearts screen after a delay
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            showOutOfHearts = true
                        }
                    } else {
                        // Still have daily hearts, show quiz failed (can retry)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            showQuizFailed = true
                        }
                    }
                } else {
                    // Premium users - just show quiz failed (no heart cost)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        showQuizFailed = true
                    }
                }
            }
        }

        showResult = true
    }

    private func resetQuestion() {
        selectedAnswer = ""
        userAnswer = ""
        showResult = false
        isCorrect = false
        mascotState = .thinking
        // Shuffle options for the new question
        if currentQuestionIndex < lesson.questions.count {
            let question = lesson.questions[currentQuestionIndex]
            shuffledOptions = (question.options ?? []).shuffled()
        }
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
                    .font(.system(size: 22))
                    .foregroundColor(textColor)
                    .multilineTextAlignment(.leading)

                Spacer()

                if isCorrect {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                        .font(.title2)
                } else if isWrong {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.red)
                        .font(.title2)
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
        .accessibilityLabel("Đáp án: \(text)")
        .accessibilityHint(isCorrect ? "Đúng" : isWrong ? "Sai" : isSelected ? "Đã chọn, nhấn đúp để bỏ chọn" : "Nhấn đúp để chọn đáp án này")
        .accessibilityAddTraits(isSelected ? .isSelected : [])
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

    @State private var animateIcon = false
    @State private var animateScore = false
    @State private var showConfetti = false

    var body: some View {
        VStack(spacing: 30) {
            Spacer()

            // Mascot celebration
            CompactMascotView(state: Mascot.stateFor(score: score), size: 70)
                .scaleEffect(animateIcon ? 1.0 : 0.5)
                .animation(.spring(response: 0.6, dampingFraction: 0.6), value: animateIcon)
                .accessibilityLabel("Linh vật ăn mừng")
                .accessibilityValue(score >= 80 ? "Rất vui - Bạn làm xuất sắc!" : "Vui vẻ - Bạn đã hoàn thành!")

            // Trophy Icon with Animation
            Image(systemName: score >= 80 ? "trophy.fill" : "star.fill")
                .resizable()
                .frame(width: 80, height: 80)
                .foregroundColor(score >= 80 ? .yellow : .orange)
                .scaleEffect(animateIcon ? 1.0 : 0.5)
                .rotationEffect(.degrees(animateIcon ? 0 : -45))
                .animation(.spring(response: 0.6, dampingFraction: 0.6), value: animateIcon)
                .onAppear {
                    animateIcon = true
                    if score >= 80 {
                        showConfetti = true
                    }
                }
                .accessibilityLabel(score >= 80 ? "Cúp vô địch" : "Ngôi sao")

            // Title
            Text(score >= 80 ? "Xuất sắc!" : "Hoàn thành!")
                .font(.system(size: 36, weight: .bold))
                .opacity(animateScore ? 1 : 0)
                .offset(y: animateScore ? 0 : 20)
                .animation(.easeOut(duration: 0.6).delay(0.3), value: animateScore)
                .accessibilityLabel(score >= 80 ? "Xuất sắc! Bạn làm rất tốt!" : "Hoàn thành bài học!")

            // Score
            Text("Điểm số: \(score)%")
                .font(.system(size: 30, weight: .semibold))
                .foregroundColor(.primary)
                .opacity(animateScore ? 1 : 0)
                .animation(.easeOut(duration: 0.6).delay(0.5), value: animateScore)
                .onAppear {
                    animateScore = true
                }
                .accessibilityLabel("Điểm số của bạn là \(score) phần trăm")

            // XP Earned or Retake Message
            if xpEarned > 0 {
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.orange)
                        .font(.title2)
                    Text("+\(xpEarned) XP")
                        .font(.system(size: 24, weight: .semibold))
                }
                .padding()
                .background(Color.orange.opacity(0.1))
                .cornerRadius(15)
                .accessibilityElement(children: .combine)
                .accessibilityLabel("Bạn nhận được \(xpEarned) điểm kinh nghiệm")
            } else {
                HStack {
                    Image(systemName: "arrow.clockwise")
                        .foregroundColor(.blue)
                        .font(.title2)
                    Text("Luyện tập lại")
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(.blue)
                }
                .padding()
                .background(Color.blue.opacity(0.1))
                .cornerRadius(15)
                .accessibilityElement(children: .combine)
                .accessibilityLabel("Luyện tập lại bài học - không nhận thêm XP")
            }

            Spacer()

            // Continue Button
            Button(action: onDismiss) {
                Text("Tiếp tục")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(15)
            }
            .padding(.horizontal, 40)
            .padding(.bottom, 40)
            .accessibilityLabel("Tiếp tục")
            .accessibilityHint("Nhấn đúp để quay lại màn hình chính")
        }
        .background(Color(.systemGroupedBackground))
        .confetti(isActive: $showConfetti)
    }
}

struct QuizFailedView: View {
    @StateObject private var localizationManager = LocalizationManager.shared
    let heartsRemaining: Int
    let isPremium: Bool
    let onRetry: () -> Void
    let onExit: () -> Void

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color.red.opacity(0.3), Color.orange.opacity(0.2)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 30) {
                Spacer()

                // Sad mascot
                CompactMascotView(state: .encouraging, size: 80)
                    .accessibilityLabel("Linh vật buồn")
                    .accessibilityValue("Động viên bạn thử lại")

                // Failed emoji
                Text("😢")
                    .font(.system(size: 60))
                    .accessibilityLabel("Emoji buồn")

                // Title
                Text(localizationManager.currentLanguage == .vietnamese ?
                     "Hết mạng rồi!" : "Out of Lives!")
                    .font(.system(size: 32, weight: .bold))
                    .accessibilityLabel(localizationManager.currentLanguage == .vietnamese ?
                     "Hết mạng rồi! Bạn đã trả lời sai 3 lần" : "Out of Lives! You answered wrong 3 times")

                // Message
                VStack(spacing: 10) {
                    Text(localizationManager.currentLanguage == .vietnamese ?
                         "Bạn đã trả lời sai 3 lần" : "You answered wrong 3 times")
                        .font(.system(size: 22))
                        .foregroundColor(.secondary)

                    if !isPremium {
                        HStack(spacing: 8) {
                            Image(systemName: "heart.fill")
                                .foregroundColor(.red)
                                .font(.title3)
                            Text(localizationManager.currentLanguage == .vietnamese ?
                                 "Đã trừ 10 điểm energy" : "Deducted 10 hearts")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(.red)
                        }
                        .padding()
                        .background(Color.red.opacity(0.1))
                        .cornerRadius(15)
                        .accessibilityElement(children: .combine)
                        .accessibilityLabel(localizationManager.currentLanguage == .vietnamese ?
                                 "Đã trừ 10 điểm energy từ tài khoản của bạn" : "Deducted 10 hearts from your account")

                        HStack(spacing: 5) {
                            Image(systemName: "heart.fill")
                                .foregroundColor(.orange)
                            Text("\(heartsRemaining) " + (localizationManager.currentLanguage == .vietnamese ?
                                 "trái tim còn lại" : "hearts remaining"))
                                .font(.system(size: 18))
                                .foregroundColor(.secondary)
                        }
                        .accessibilityElement(children: .combine)
                        .accessibilityLabel("\(heartsRemaining) " + (localizationManager.currentLanguage == .vietnamese ?
                                 "trái tim còn lại trong tài khoản" : "hearts remaining in your account"))
                    }
                }

                Spacer()

                // Buttons
                VStack(spacing: 15) {
                    // Retry button
                    Button(action: onRetry) {
                        HStack {
                            Image(systemName: "arrow.clockwise")
                                .font(.title3)
                            Text(localizationManager.currentLanguage == .vietnamese ?
                                 "Thử lại (Trừ 10 hearts nếu sai tiếp)" : "Retry (Costs 10 hearts if fail again)")
                        }
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(15)
                    }
                    .accessibilityLabel(localizationManager.currentLanguage == .vietnamese ?
                         "Thử lại bài quiz" : "Retry quiz")
                    .accessibilityHint(localizationManager.currentLanguage == .vietnamese ?
                         "Nhấn đúp để thử lại. Sẽ trừ 10 hearts nếu bạn sai lại 3 lần" : "Double tap to retry. Costs 10 hearts if you fail again")

                    // Exit button
                    Button(action: onExit) {
                        Text(localizationManager.currentLanguage == .vietnamese ?
                             "Quay lại" : "Go Back")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.blue)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(15)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.blue, lineWidth: 2)
                            )
                    }
                    .accessibilityLabel(localizationManager.currentLanguage == .vietnamese ?
                         "Quay lại màn hình chính" : "Go back to home screen")
                    .accessibilityHint(localizationManager.currentLanguage == .vietnamese ?
                         "Nhấn đúp để quay lại" : "Double tap to go back")
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 40)
            }
        }
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
            .environmentObject(SubscriptionManager())
    }
}

// MARK: - String Extension for Vietnamese Text Normalization
extension String {
    /// Normalizes text for comparison, handling Vietnamese diacritical variants
    /// Examples:
    /// - "khỏe" and "khoẻ" both normalize to the same value
    /// - "Bạn khỏe không" and "Bạn khoẻ không" are considered equal
    /// - Case-insensitive and whitespace-trimmed
    func normalized() -> String {
        return self
            .lowercased()
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .folding(options: [.diacriticInsensitive, .caseInsensitive], locale: .current)
            .replacingOccurrences(of: " +", with: " ", options: .regularExpression)
    }
}
