import SwiftUI

struct LearningContentView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var ttsService = TextToSpeechService.shared
    @StateObject private var localizationManager = LocalizationManager.shared
    private let soundService = SoundEffectService.shared

    let lesson: Lesson
    let onStartQuiz: () -> Void

    @State private var currentPage = 0

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Progress indicator
                HStack(spacing: 8) {
                    ForEach(0..<max(1, lesson.vocabularyItems.count), id: \.self) { index in
                        Circle()
                            .fill(currentPage == index ? Color.blue : Color.gray.opacity(0.3))
                            .frame(width: 8, height: 8)
                    }
                }
                .padding(.top, 20)
                .padding(.bottom, 10)

                // Content
                if lesson.vocabularyItems.isEmpty {
                    // If no vocabulary, show simple intro
                    VStack(spacing: 30) {
                        Spacer()

                        CompactMascotView(state: .happy, size: 80)

                        Text(localizationManager.currentLanguage == .vietnamese ?
                             "Sẵn sàng học bài mới?" : "Ready to learn?")
                            .font(.title)
                            .fontWeight(.bold)

                        Text(lesson.title)
                            .font(.title2)
                            .foregroundColor(.secondary)

                        Text(lesson.description)
                            .font(.body)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)

                        Spacer()
                    }
                } else {
                    TabView(selection: $currentPage) {
                        ForEach(Array(lesson.vocabularyItems.enumerated()), id: \.element.id) { index, item in
                            VocabularyCardView(item: item)
                                .tag(index)
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                }

                // Navigation buttons
                VStack(spacing: 15) {
                    if !lesson.vocabularyItems.isEmpty {
                        HStack(spacing: 20) {
                            // Previous button
                            if currentPage > 0 {
                                Button(action: {
                                    withAnimation {
                                        currentPage -= 1
                                    }
                                    soundService.playTapSound()
                                }) {
                                    HStack {
                                        Image(systemName: "chevron.left")
                                        Text(localizationManager.currentLanguage == .vietnamese ?
                                             "Trước" : "Previous")
                                    }
                                    .font(.headline)
                                    .foregroundColor(.blue)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.blue.opacity(0.1))
                                    .cornerRadius(15)
                                }
                            }

                            // Next button or Start Quiz
                            if currentPage < lesson.vocabularyItems.count - 1 {
                                Button(action: {
                                    withAnimation {
                                        currentPage += 1
                                    }
                                    soundService.playTapSound()
                                }) {
                                    HStack {
                                        Text(localizationManager.currentLanguage == .vietnamese ?
                                             "Tiếp" : "Next")
                                        Image(systemName: "chevron.right")
                                    }
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.blue)
                                    .cornerRadius(15)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }

                    // Start Quiz button
                    if lesson.vocabularyItems.isEmpty || currentPage == lesson.vocabularyItems.count - 1 {
                        Button(action: {
                            soundService.playTapSound()
                            onStartQuiz()
                        }) {
                            HStack {
                                Image(systemName: "play.fill")
                                Text(localizationManager.currentLanguage == .vietnamese ?
                                     "Bắt đầu làm bài" : "Start Quiz")
                            }
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                LinearGradient(
                                    colors: [Color.green, Color.blue],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(15)
                            .shadow(color: .green.opacity(0.3), radius: 10, y: 5)
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical, 20)
            }
            .navigationTitle(localizationManager.currentLanguage == .vietnamese ?
                           "Học từ vựng" : "Study")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                trailing: Button(localizationManager.currentLanguage == .vietnamese ?
                                "Đóng" : "Close") {
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
}

struct VocabularyCardView: View {
    @StateObject private var ttsService = TextToSpeechService.shared
    let item: VocabularyItem

    @State private var showTranslation = false

    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                Spacer()

                // English word with speaker
                VStack(spacing: 15) {
                    Text(item.english)
                        .font(.system(size: 48, weight: .bold))
                        .foregroundColor(.primary)

                    Button(action: {
                        ttsService.speak(item.english)
                    }) {
                        HStack {
                            Image(systemName: ttsService.isSpeaking ? "speaker.wave.3.fill" : "speaker.wave.2.fill")
                                .font(.title2)
                            Text("Nghe phát âm")
                                .font(.headline)
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal, 25)
                        .padding(.vertical, 12)
                        .background(Color.blue)
                        .cornerRadius(25)
                    }
                }
                .padding(.top, 40)

                // Divider
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 1)
                    .frame(maxWidth: 200)

                // Vietnamese translation
                VStack(spacing: 10) {
                    Text("Nghĩa")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    Text(item.vietnamese)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.green)
                }

                // Example
                VStack(spacing: 10) {
                    Text("Ví dụ")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    Text(item.example)
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .padding()
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(15)

                    Button(action: {
                        ttsService.speak(item.example)
                    }) {
                        HStack {
                            Image(systemName: "speaker.wave.2.fill")
                            Text("Nghe ví dụ")
                                .font(.caption)
                        }
                        .foregroundColor(.blue)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 8)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(15)
                    }
                }
                .padding(.horizontal)

                Spacer()
            }
            .padding()
        }
    }
}

struct LearningContentView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleLesson = Lesson(
            title: "Greetings",
            description: "Learn basic greetings",
            level: 1,
            xpReward: 10,
            vocabularyItems: [
                VocabularyItem(
                    english: "Hello",
                    vietnamese: "Xin chào",
                    example: "Hello! How are you?"
                ),
                VocabularyItem(
                    english: "Good morning",
                    vietnamese: "Chào buổi sáng",
                    example: "Good morning, teacher!"
                )
            ],
            questions: []
        )

        return LearningContentView(lesson: sampleLesson) {
            print("Start quiz")
        }
    }
}
