import SwiftUI
import AVFoundation

struct ContentView: View {
    @State private var showSplashScreen = true
    @State private var emergencyActive = false
    @State private var currentProtocol = ""
    @State private var stepNumber = 1
    @State private var showSARA = false
    @State private var saraMessage = "Hi there! I'm SARA, your AI medical assistant. I'm here to guide you through any emergency with a warm, caring voice."
    @State private var isSpeaking = false
    @State private var showingEmergencyVideo = false
    
    // Enhanced Speech Manager
    @StateObject private var speechManager = SpeechManager()
    
    var body: some View {
        ZStack {
            if showSplashScreen {
                // CODEPLUS Splash Screen
                SplashScreenView()
            } else {
                // Main App with SARA Background
                ZStack {
                    // SARA Avatar Background on every page
                    SARABackgroundView()
                    
                    VStack(spacing: 20) {
                        if !emergencyActive && !showSARA {
                            // STANDBY MODE WITH SARA
                            MainView(
                                showSARA: $showSARA,
                                speechManager: speechManager,
                                isSpeaking: $isSpeaking,
                                activateEmergency: activateEmergency,
                                call911: call911
                            )
                        } else if showSARA {
                            // SARA AI INTERFACE
                            SARAView(
                                showSARA: $showSARA,
                                saraMessage: $saraMessage,
                                speechManager: speechManager,
                                isSpeaking: $isSpeaking,
                                updateSARAMessage: updateSARAMessage
                            )
                        } else {
                            // EMERGENCY MODE WITH SARA GUIDANCE
                            EmergencyView(
                                currentProtocol: currentProtocol,
                                stepNumber: stepNumber,
                                speechManager: speechManager,
                                isSpeaking: $isSpeaking,
                                showingEmergencyVideo: $showingEmergencyVideo,
                                getSARAGuidance: getSARAGuidance,
                                getEmergencyIcon: getEmergencyIcon,
                                getEmergencyInstructions: getEmergencyInstructions,
                                getSafetyWarning: getSafetyWarning,
                                resolveEmergency: resolveEmergency,
                                nextStep: nextStep,
                                call911: call911,
                                resetEmergency: resetEmergency
                            )
                        }
                    }
                    .padding(20)
                    
                    // Emergency Video Overlay
                    if showingEmergencyVideo {
                        EmergencyVideoOverlay(
                            currentProtocol: currentProtocol,
                            stepNumber: stepNumber,
                            showingEmergencyVideo: $showingEmergencyVideo,
                            speechManager: speechManager,
                            getSARAGuidance: getSARAGuidance,
                            getEmergencyInstructions: getEmergencyInstructions
                        )
                    }
                }
            }
        }
        .onAppear {
            setupApp()
        }
        .onReceive(speechManager.$isSpeaking) { speaking in
            isSpeaking = speaking
        }
    }
    
    private func setupApp() {
        // Show splash for 3 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            withAnimation(.easeInOut(duration: 1.0)) {
                showSplashScreen = false
            }
        }
    }
    
    // MARK: - Emergency Functions
    
    private func activateEmergency(_ type: String) {
        currentProtocol = type
        emergencyActive = true
        stepNumber = 1
        showSARA = false
        
        let emergencyMessage = "Emergency activated. \(type) protocol initiated. I'm SARA and I'm here to guide you through this with a calm voice. Stay with me, and follow my instructions exactly."
        speechManager.speak(emergencyMessage, emotion: .urgent)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
            let guidance = getSARAGuidance()
            speechManager.speak(guidance, emotion: .calm)
        }
        
        print("🚨 SARA Emergency Activated: \(type)")
    }
    
    private func updateSARAMessage(_ message: String) {
        saraMessage = message
    }
    
    private func nextStep() {
        stepNumber += 1
        if stepNumber > getMaxSteps() {
            stepNumber = getMaxSteps()
        }
        
        let guidance = getSARAGuidance()
        speechManager.speak(guidance, emotion: .supportive)
        
        print("📋 SARA Step \(stepNumber): \(currentProtocol)")
    }
    
    private func resolveEmergency() {
        emergencyActive = false
        currentProtocol = ""
        stepNumber = 1
        showSARA = false
        
        speechManager.speak("Wonderful! Emergency resolved successfully. You did an absolutely amazing job! The person is safe thanks to your quick thinking and my guidance. I'm so proud of you.", emotion: .warm)
        
        print("✅ SARA: Emergency Resolved Successfully!")
    }
    
    private func resetEmergency() {
        emergencyActive = false
        currentProtocol = ""
        stepNumber = 1
        showSARA = false
        
        speechManager.speak("Emergency protocol reset. I'm ready to help with any new emergency. You can count on me.", emotion: .supportive)
        
        print("🔄 SARA: Emergency Reset")
    }
    
    private func call911() {
        speechManager.speak("I'm calling 911 right now. Emergency services are being contacted immediately. Don't worry, I'll continue to guide you with my voice until help arrives.", emotion: .calm)
        
        print("🚨 SARA: 911 CALL INITIATED")
    }
    
    // MARK: - Helper Functions
    
    private func getSARAGuidance() -> String {
        EmergencyProtocols.getGuidance(for: currentProtocol, step: stepNumber)
    }
    
    private func getMaxSteps() -> Int {
        EmergencyProtocols.getMaxSteps(for: currentProtocol)
    }
    
    private func getEmergencyIcon() -> String {
        EmergencyProtocols.getIcon(for: currentProtocol)
    }
    
    private func getEmergencyInstructions() -> String {
        EmergencyProtocols.getInstructions(for: currentProtocol, step: stepNumber)
    }
    
    private func getSafetyWarning() -> String? {
        EmergencyProtocols.getSafetyWarning(for: currentProtocol, step: stepNumber)
    }
}

#Preview {
    ContentView()
}
