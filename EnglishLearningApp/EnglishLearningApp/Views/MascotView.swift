import SwiftUI

/// Animated mascot character view
struct MascotView: View {
    let state: MascotState
    let showMessage: Bool
    let size: CGFloat

    @State private var isAnimating = false
    @State private var bounce = false
    @State private var rotate = false

    init(state: MascotState, showMessage: Bool = true, size: CGFloat = 80) {
        self.state = state
        self.showMessage = showMessage
        self.size = size
    }

    var body: some View {
        VStack(spacing: 15) {
            // Mascot character with animation
            ZStack {
                // Background glow effect
                Circle()
                    .fill(
                        RadialGradient(
                            gradient: Gradient(colors: [state.color.opacity(0.3), .clear]),
                            center: .center,
                            startRadius: 0,
                            endRadius: size / 2
                        )
                    )
                    .frame(width: size * 1.5, height: size * 1.5)
                    .scaleEffect(isAnimating ? 1.2 : 1.0)
                    .opacity(isAnimating ? 0.5 : 1.0)
                    .animation(
                        Animation.easeInOut(duration: 1.5)
                            .repeatForever(autoreverses: true),
                        value: isAnimating
                    )

                // Mascot emoji
                Text(state.emoji)
                    .font(.system(size: size))
                    .scaleEffect(bounce ? 1.1 : 1.0)
                    .rotationEffect(.degrees(rotate ? 5 : -5))
                    .animation(
                        Animation.easeInOut(duration: 0.5)
                            .repeatForever(autoreverses: true),
                        value: bounce
                    )
                    .animation(
                        Animation.easeInOut(duration: 0.8)
                            .repeatForever(autoreverses: true),
                        value: rotate
                    )
            }
            .onAppear {
                isAnimating = true
                bounce = true
                rotate = true
            }

            // Message bubble
            if showMessage {
                MessageBubble(text: state.message, color: state.color)
            }
        }
    }
}

/// Speech bubble for mascot messages
struct MessageBubble: View {
    let text: String
    let color: Color

    var body: some View {
        VStack(spacing: 0) {
            // Triangle pointer
            Triangle()
                .fill(color.opacity(0.2))
                .frame(width: 20, height: 10)

            // Message text
            Text(text)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(color.opacity(0.2))
                )
        }
        .frame(maxWidth: 250)
    }
}

/// Triangle shape for speech bubble pointer
struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

/// Compact mascot view without message (for small spaces)
struct CompactMascotView: View {
    let state: MascotState
    let size: CGFloat

    @State private var bounce = false

    init(state: MascotState, size: CGFloat = 40) {
        self.state = state
        self.size = size
    }

    var body: some View {
        Text(state.emoji)
            .font(.system(size: size))
            .scaleEffect(bounce ? 1.15 : 1.0)
            .animation(
                Animation.easeInOut(duration: 0.6)
                    .repeatForever(autoreverses: true),
                value: bounce
            )
            .onAppear {
                bounce = true
            }
    }
}

/// Floating mascot that appears from the side
struct FloatingMascot: View {
    let state: MascotState
    let message: String?
    let duration: TimeInterval

    @State private var isShowing = false
    @State private var opacity = 0.0

    init(state: MascotState, message: String? = nil, duration: TimeInterval = 3.0) {
        self.state = state
        self.message = message ?? state.message
        self.duration = duration
    }

    var body: some View {
        HStack {
            Spacer()

            VStack(spacing: 10) {
                CompactMascotView(state: state, size: 50)

                if let message = message {
                    Text(message)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 8)
                        .background(
                            Capsule()
                                .fill(state.color)
                        )
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .shadow(radius: 10)
            )
            .offset(x: isShowing ? 0 : 300)
            .opacity(opacity)
            .animation(.spring(response: 0.6, dampingFraction: 0.7), value: isShowing)
        }
        .padding()
        .onAppear {
            // Show animation
            withAnimation {
                isShowing = true
                opacity = 1.0
            }

            // Auto-hide after duration
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                withAnimation {
                    isShowing = false
                    opacity = 0.0
                }
            }
        }
    }
}

// MARK: - Previews
struct MascotView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 40) {
            MascotView(state: .happy)
            MascotView(state: .celebrating)
            MascotView(state: .encouraging)
            CompactMascotView(state: .waving)
        }
        .padding()
    }
}
