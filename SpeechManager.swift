import AVFoundation
import SwiftUI

class SpeechManager: NSObject, ObservableObject, AVSpeechSynthesizerDelegate {
    @Published var isSpeaking = false
    
    private let speechSynthesizer = AVSpeechSynthesizer()
    
    enum SpeechEmotion {
        case calm, urgent, caring, friendly, supportive, helpful, warm
    }
    
    override init() {
        super.init()
        speechSynthesizer.delegate = self
        configureAudioSession()
    }
    
    private func configureAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .spokenAudio, options: [.duckOthers])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Audio session configuration failed: \(error)")
        }
    }
    
    func speak(_ text: String, emotion: SpeechEmotion = .calm) {
        // Stop any current speech
        speechSynthesizer.stopSpeaking(at: .immediate)
        
        // Create enhanced speech utterance
        let enhancedText = enhanceTextForNaturalSpeech(text, emotion: emotion)
        let utterance = AVSpeechUtterance(string: enhancedText)
        
        // Configure for most natural voice possible
        if let voice = getBestHumanVoice() {
            utterance.voice = voice
        }
        
        // Set emotion-based voice characteristics
        configureVoiceCharacteristics(for: utterance, emotion: emotion)
        
        // Start speaking
        isSpeaking = true
        speechSynthesizer.speak(utterance)
        
        print("🗣️ SARA (\(emotion)): \(enhancedText)")
    }
    
    private func configureVoiceCharacteristics(for utterance: AVSpeechUtterance, emotion: SpeechEmotion) {
        switch emotion {
        case .calm:
            utterance.rate = 0.48
            utterance.pitchMultiplier = 1.0
            utterance.volume = 0.95
        case .urgent:
            utterance.rate = 0.52
            utterance.pitchMultiplier = 1.05
            utterance.volume = 1.0
        case .caring:
            utterance.rate = 0.44
            utterance.pitchMultiplier = 1.02
            utterance.volume = 0.90
        case .friendly:
            utterance.rate = 0.50
            utterance.pitchMultiplier = 1.08
            utterance.volume = 0.95
        case .supportive:
            utterance.rate = 0.46
            utterance.pitchMultiplier = 1.0
            utterance.volume = 0.92
        case .helpful:
            utterance.rate = 0.49
            utterance.pitchMultiplier = 1.03
            utterance.volume = 0.94
        case .warm:
            utterance.rate = 0.45
            utterance.pitchMultiplier = 1.06
            utterance.volume = 0.88
        }
        
        utterance.preUtteranceDelay = 0.2
        utterance.postUtteranceDelay = 0.1
    }
    
    private func getBestHumanVoice() -> AVSpeechSynthesisVoice? {
        let voices = AVSpeechSynthesisVoice.speechVoices()
        
        let preferredVoiceNames = [
            "Samantha", "Ava", "Susan", "Allison", "Victoria", "Siri Female", "Alex"
        ]
        
        // Find voices by name (most natural)
        for voiceName in preferredVoiceNames {
            if let voice = voices.first(where: { $0.name.contains(voiceName) && $0.language.hasPrefix("en") }) {
                print("✅ Using natural voice: \(voice.name)")
                return voice
            }
        }
        
        // Fallback: Find any high-quality English voice
        let englishVoices = voices.filter { $0.language.hasPrefix("en") }
        
        let enhancedVoices = englishVoices.filter { voice in
            voice.identifier.contains("premium") || 
            voice.identifier.contains("enhanced") ||
            voice.quality == .enhanced
        }
        
        if let enhancedVoice = enhancedVoices.first {
            print("✅ Using enhanced voice: \(enhancedVoice.name)")
            return enhancedVoice
        }
        
        if let anyEnglishVoice = englishVoices.first {
            print("⚠️ Using fallback voice: \(anyEnglishVoice.name)")
            return anyEnglishVoice
        }
        
        print("❌ No suitable voice found, using system default")
        return nil
    }
    
    private func enhanceTextForNaturalSpeech(_ text: String, emotion: SpeechEmotion) -> String {
        var enhancedText = text
        
        // Add natural breathing pauses
        enhancedText = enhancedText.replacingOccurrences(of: ". ", with: "... ")
        enhancedText = enhancedText.replacingOccurrences(of: "! ", with: "... ")
        enhancedText = enhancedText.replacingOccurrences(of: "? ", with: "... ")
        
        // Add natural speech patterns based on emotion
        switch emotion {
        case .calm:
            enhancedText = "Okay... " + enhancedText
        case .urgent:
            enhancedText = enhancedText.replacingOccurrences(of: "immediately", with: "right now")
            enhancedText = enhancedText.replacingOccurrences(of: "quickly", with: "fast")
        case .caring:
            enhancedText = "Don't worry... " + enhancedText
        case .friendly:
            enhancedText = enhancedText.replacingOccurrences(of: "Hello", with: "Hello there")
        case .supportive:
            enhancedText = "I'm right here with you... " + enhancedText
        case .helpful:
            enhancedText = "Let me help you with this... " + enhancedText
        case .warm:
            enhancedText = enhancedText.replacingOccurrences(of: "I can", with: "I'd love to")
        }
        
        return enhancedText
    }
    
    func stopSpeaking() {
        speechSynthesizer.stopSpeaking(at: .immediate)
        isSpeaking = false
    }
    
    // MARK: - AVSpeechSynthesizerDelegate
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        DispatchQueue.main.async {
            self.isSpeaking = true
        }
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        DispatchQueue.main.async {
            self.isSpeaking = false
        }
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        DispatchQueue.main.async {
            self.isSpeaking = false
        }
    }
}
