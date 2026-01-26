import Foundation
import AVFoundation
import AudioToolbox

class SoundEffectService {
    static let shared = SoundEffectService()

    private var audioPlayers: [String: AVAudioPlayer] = [:]

    private init() {
        configureAudioSession()
    }

    private func configureAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set up audio session: \(error)")
        }
    }

    // Play system sound for correct answer (ding sound)
    func playCorrectSound() {
        // System sound ID 1054 = "Tock" sound (success)
        AudioServicesPlaySystemSound(1054)

        // Optional: Add haptic feedback
        let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
        impactFeedback.impactOccurred()
    }

    // Play system sound for wrong answer (buzz sound)
    func playWrongSound() {
        // System sound ID 1053 = "Tink" sound (error-like)
        AudioServicesPlaySystemSound(1053)

        // Optional: Add haptic feedback
        let notificationFeedback = UINotificationFeedbackGenerator()
        notificationFeedback.notificationOccurred(.error)
    }

    // Play celebration sound for high score
    func playCelebrationSound() {
        // System sound ID 1027 = "Tweet" sound (happy/celebration)
        AudioServicesPlaySystemSound(1027)

        // Haptic for celebration
        let notificationFeedback = UINotificationFeedbackGenerator()
        notificationFeedback.notificationOccurred(.success)
    }

    // Play button tap sound
    func playTapSound() {
        // System sound ID 1104 = "Tock" (subtle tap)
        AudioServicesPlaySystemSound(1104)
    }

    // Play level up sound
    func playLevelUpSound() {
        // System sound ID 1025 = "New Mail" sound (achievement-like)
        AudioServicesPlaySystemSound(1025)

        let notificationFeedback = UINotificationFeedbackGenerator()
        notificationFeedback.notificationOccurred(.success)
    }
}
