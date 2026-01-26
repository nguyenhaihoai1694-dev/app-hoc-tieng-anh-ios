import Foundation
import AVFoundation

class TextToSpeechService: NSObject, ObservableObject {
    static let shared = TextToSpeechService()

    private let synthesizer = AVSpeechSynthesizer()
    @Published var isSpeaking = false

    private override init() {
        super.init()
        synthesizer.delegate = self
    }

    /// Speak English text with appropriate voice
    func speak(_ text: String, language: String = "en-US", rate: Float = 0.5) {
        // Stop any ongoing speech
        if synthesizer.isSpeaking {
            synthesizer.stopSpeaking(at: .immediate)
        }

        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: language)
        utterance.rate = rate // Slower rate for kids (0.0-1.0)
        utterance.pitchMultiplier = 1.1 // Slightly higher pitch for kid-friendly voice
        utterance.volume = 1.0

        synthesizer.speak(utterance)
        isSpeaking = true
    }

    /// Speak Vietnamese text
    func speakVietnamese(_ text: String, rate: Float = 0.5) {
        speak(text, language: "vi-VN", rate: rate)
    }

    /// Stop current speech
    func stop() {
        if synthesizer.isSpeaking {
            synthesizer.stopSpeaking(at: .immediate)
            isSpeaking = false
        }
    }
}

// MARK: - AVSpeechSynthesizerDelegate
extension TextToSpeechService: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        isSpeaking = false
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        isSpeaking = false
    }
}
