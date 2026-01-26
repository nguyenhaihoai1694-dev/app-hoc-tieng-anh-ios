import SwiftUI

/// Parent Gate to prevent kids from making in-app purchases
/// Required for COPPA compliance and App Store Kids Category
struct ParentGateView: View {
    @Environment(\.dismiss) private var dismiss
    let onSuccess: () -> Void

    @State private var userAnswer: String = ""
    @State private var showError = false
    @State private var attempts = 0

    // Generate a simple math problem for parents
    private let number1 = Int.random(in: 5...15)
    private let number2 = Int.random(in: 5...15)

    private var correctAnswer: Int {
        number1 + number2
    }

    var body: some View {
        ZStack {
            // Background
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.purple.opacity(0.3)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 30) {
                // Close button
                HStack {
                    Spacer()
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.gray)
                    }
                    .padding()
                }

                Spacer()

                // Parent Gate Icon
                Image(systemName: "person.fill.checkmark")
                    .font(.system(size: 70))
                    .foregroundColor(.blue)
                    .padding(.bottom, 20)

                // Title
                Text("Cổng Dành Cho Phụ Huynh")
                    .font(.system(size: 28, weight: .bold))
                    .multilineTextAlignment(.center)

                // Instructions
                Text("Để bảo vệ trẻ em, vui lòng giải bài toán sau:")
                    .font(.system(size: 18))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                // Math problem
                VStack(spacing: 20) {
                    Text("\(number1) + \(number2) = ?")
                        .font(.system(size: 48, weight: .bold))
                        .foregroundColor(.primary)

                    // Answer input
                    TextField("Nhập đáp án", text: $userAnswer)
                        .keyboardType(.numberPad)
                        .font(.system(size: 32, weight: .semibold))
                        .multilineTextAlignment(.center)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(radius: 5)
                        .frame(maxWidth: 200)
                }
                .padding()
                .background(Color.white.opacity(0.7))
                .cornerRadius(20)

                // Error message
                if showError {
                    Text(attempts >= 3 ? "Quá nhiều lần thử. Vui lòng thử lại sau." : "Đáp án không đúng. Vui lòng thử lại.")
                        .font(.system(size: 16))
                        .foregroundColor(.red)
                        .padding(.horizontal)
                        .multilineTextAlignment(.center)
                }

                // Submit button
                Button(action: checkAnswer) {
                    Text("Xác Nhận")
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: 250)
                        .padding()
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.blue, Color.purple]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(15)
                        .shadow(radius: 5)
                }
                .disabled(attempts >= 3)
                .opacity(attempts >= 3 ? 0.5 : 1.0)

                Spacer()

                // Privacy notice
                Text("Đây là cổng bảo vệ trẻ em theo quy định COPPA")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.bottom)
            }
        }
    }

    private func checkAnswer() {
        guard let answer = Int(userAnswer) else {
            showError = true
            return
        }

        if answer == correctAnswer {
            // Correct answer - parent verified
            showError = false
            SoundEffectService.shared.playCorrectSound()

            // Dismiss and proceed with success action
            dismiss()
            onSuccess()
        } else {
            // Wrong answer
            attempts += 1
            showError = true
            SoundEffectService.shared.playWrongSound()
            userAnswer = ""

            // Block after 3 failed attempts
            if attempts >= 3 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    dismiss()
                }
            }
        }
    }
}

// MARK: - Preview
struct ParentGateView_Previews: PreviewProvider {
    static var previews: some View {
        ParentGateView {
            print("Parent gate passed!")
        }
    }
}
