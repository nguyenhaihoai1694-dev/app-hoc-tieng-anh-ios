import SwiftUI

struct ConfettiView: View {
    @State private var animate = false
    let colors: [Color] = [.red, .blue, .green, .yellow, .orange, .purple, .pink]

    var body: some View {
        ZStack {
            ForEach(0..<50, id: \.self) { index in
                ConfettiPiece(color: colors.randomElement() ?? .blue, index: index)
                    .opacity(animate ? 0 : 1)
                    .offset(y: animate ? 800 : -50)
                    .animation(
                        Animation.linear(duration: Double.random(in: 2...4))
                            .repeatForever(autoreverses: false)
                            .delay(Double.random(in: 0...0.5)),
                        value: animate
                    )
            }
        }
        .onAppear {
            animate = true
        }
        .allowsHitTesting(false)
    }
}

struct ConfettiPiece: View {
    let color: Color
    let index: Int
    @State private var rotation: Double = 0

    var body: some View {
        Circle()
            .fill(color)
            .frame(width: CGFloat.random(in: 5...10), height: CGFloat.random(in: 5...10))
            .position(
                x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                y: -20
            )
            .rotationEffect(.degrees(rotation))
            .onAppear {
                withAnimation(
                    Animation.linear(duration: 1)
                        .repeatForever(autoreverses: false)
                ) {
                    rotation = 360
                }
            }
    }
}

// MARK: - Confetti Modifier
struct ConfettiModifier: ViewModifier {
    @Binding var isActive: Bool
    @State private var showConfetti = false

    func body(content: Content) -> some View {
        content
            .overlay(
                Group {
                    if showConfetti {
                        ConfettiView()
                    }
                }
            )
            .onChange(of: isActive) { newValue in
                if newValue {
                    showConfetti = true
                    // Hide confetti after 5 seconds
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        showConfetti = false
                        isActive = false
                    }
                }
            }
    }
}

extension View {
    func confetti(isActive: Binding<Bool>) -> some View {
        self.modifier(ConfettiModifier(isActive: isActive))
    }
}
