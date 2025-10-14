import SwiftUI

// MARK: - Splash Screen View

struct SplashScreenView: View {
    @State private var animateElements = true
    
    var body: some View {
        ZStack {
            // Dynamic gradient background
            LinearGradient(
                colors: [
                    Color(red: 0.0, green: 0.1, blue: 0.2),
                    Color(red: 0.05, green: 0.15, blue: 0.25),
                    Color.black
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 30) {
                
                Spacer()
                
                // CODEPLUS Logo
                VStack(spacing: 20) {
                    // Large Medical Cross with Animation
                    ZStack {
                        // Outer glow ring
                        Circle()
                            .fill(Color.clear)
                            .frame(width: 200, height: 200)
                            .overlay(
                                Circle()
                                    .stroke(
                                        LinearGradient(colors: [.cyan, .blue], startPoint: .topLeading, endPoint: .bottomTrailing),
                                        lineWidth: 4
                                    )
                                    .shadow(color: .cyan, radius: 20)
                            )
                        
                        // Main logo circle
                        Circle()
                            .fill(
                                RadialGradient(
                                    colors: [Color.cyan.opacity(0.8), Color.blue],
                                    center: .center,
                                    startRadius: 10,
                                    endRadius: 80
                                )
                            )
                            .frame(width: 160, height: 160)
                            .shadow(color: .cyan, radius: 15)
                        
                        // Medical cross with heartbeat
                        VStack(spacing: -5) {
                            Image(systemName: "cross.case.fill")
                                .font(.system(size: 60, weight: .bold))
                                .foregroundColor(.white)
                                .shadow(color: .white, radius: 5)
                            
                            // Animated heartbeat line
                            Image(systemName: "waveform.path.ecg")
                                .font(.system(size: 30))
                                .foregroundColor(.white.opacity(0.9))
                        }
                    }
                    
                    // CODEPLUS Title
                    Text("CODEPLUS")
                        .font(.system(size: 56, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .shadow(color: .cyan, radius: 10)
                    
                    // Subtitle
                    Text("Guided by SARA AI")
                        .font(.system(size: 24, weight: .medium))
                        .foregroundColor(.cyan)
                    
                    Text("Emergency Response System")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.white.opacity(0.8))
                }
                
                Spacer()
                
                // Loading Animation
                VStack(spacing: 15) {
                    HStack(spacing: 8) {
                        ForEach(0..<3) { index in
                            Circle()
                                .fill(Color.cyan)
                                .frame(width: 12, height: 12)
                        }
                    }
                    
                    Text("Initializing SARA AI...")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white.opacity(0.7))
                }
                
                Spacer()
            }
        }
    }
}

// MARK: - SARA Background View

struct SARABackgroundView: View {
    var body: some View {
        ZStack {
            // Base gradient background
            LinearGradient(
                colors: [Color(red: 0.05, green: 0.15, blue: 0.25), Color.black],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            // Large SARA Avatar in background
            VStack {
                Spacer()
                
                ZStack {
                    // SARA silhouette - much larger and more prominent
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [Color.cyan.opacity(0.15), Color.blue.opacity(0.05), Color.clear],
                                center: .center,
                                startRadius: 100,
                                endRadius: 300
                            )
                        )
                        .frame(width: 600, height: 600)
                    
                    // SARA figure outline - larger and more visible
                    VStack(spacing: 20) {
                        // SARA head
                        Circle()
                            .stroke(Color.cyan.opacity(0.12), lineWidth: 3)
                            .frame(width: 80, height: 80)
                            .overlay(
                                Image(systemName: "brain.head.profile")
                                    .font(.system(size: 40, weight: .light))
                                    .foregroundColor(.cyan.opacity(0.1))
                            )
                        
                        // SARA body
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.cyan.opacity(0.1), lineWidth: 2)
                            .frame(width: 120, height: 180)
                            .overlay(
                                VStack(spacing: 15) {
                                    Image(systemName: "cross.case")
                                        .font(.system(size: 30, weight: .light))
                                        .foregroundColor(.cyan.opacity(0.08))
                                    
                                    Image(systemName: "heart.fill")
                                        .font(.system(size: 25, weight: .light))
                                        .foregroundColor(.cyan.opacity(0.08))
                                    
                                    Image(systemName: "waveform.path.ecg")
                                        .font(.system(size: 20, weight: .light))
                                        .foregroundColor(.cyan.opacity(0.08))
                                }
                            )
                    }
                    
                    // Floating medical symbols around SARA
                    ForEach(0..<12, id: \.self) { index in
                        let angle = Double(index) * 30
                        let radius: CGFloat = 220
                        let x = cos(angle * .pi / 180) * radius
                        let y = sin(angle * .pi / 180) * radius
                        
                        Image(systemName: getMedicalSymbol(index: index))
                            .font(.system(size: 25, weight: .light))
                            .foregroundColor(.cyan.opacity(0.08))
                            .offset(x: x, y: y)
                            .rotationEffect(.degrees(angle))
                    }
                    
                    // SARA name subtly in background
                    Text("SARA")
                        .font(.system(size: 120, weight: .ultraLight, design: .rounded))
                        .foregroundColor(.cyan.opacity(0.03))
                        .offset(y: 100)
                }
                
                Spacer()
            }
        }
    }
    
    private func getMedicalSymbol(index: Int) -> String {
        let symbols = [
            "heart.fill", "brain.head.profile", "lungs.fill", "pills.fill",
            "stethoscope", "cross.case", "phone.fill", "waveform.path.ecg",
            "syringe", "bandage", "thermometer", "pulse"
        ]
        return symbols[index % symbols.count]
    }
}

// MARK: - Main View

struct MainView: View {
    @Binding var showSARA: Bool
    let speechManager: SpeechManager
    @Binding var isSpeaking: Bool
    let activateEmergency: (String) -> Void
    let call911: () -> Void
    
    var body: some View {
        VStack(spacing: 30) {
            
            Spacer()
            
            // Compact CODEPLUS Header
            VStack(spacing: 12) {
                // Smaller logo
                ZStack {
                    Circle()
                        .fill(Color.black.opacity(0.4))
                        .frame(width: 100, height: 100)
                        .overlay(
                            Circle()
                                .stroke(Color.cyan.opacity(0.3), lineWidth: 2)
                        )
                    
                    Image(systemName: "cross.case.fill")
                        .font(.system(size: 45, weight: .bold))
                        .foregroundColor(Color.cyan)
                        .shadow(color: .cyan, radius: 8)
                }
                
                Text("CODEPLUS")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .shadow(color: .cyan.opacity(0.5), radius: 5)
                
                Text("SARA AI Ready")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.cyan)
                
                // System Status
                HStack(spacing: 8) {
                    Circle()
                        .fill(Color.green)
                        .frame(width: 10, height: 10)
                        .shadow(color: .green, radius: 3)
                    Text("Natural Human Voice Online")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.green)
                    
                    if isSpeaking {
                        Image(systemName: "speaker.wave.3.fill")
                            .font(.system(size: 12))
                            .foregroundColor(.cyan)
                    }
                }
            }
            
            Spacer()
            
            // SARA AI Assistant Button
            Button(action: {
                showSARA = true
                speechManager.speak("Hello there! I'm SARA, your AI medical assistant. I'm here to help you with a warm, human voice. How can I assist you today?", emotion: .friendly)
            }) {
                HStack(spacing: 15) {
                    // SARA Avatar
                    ZStack {
                        Circle()
                            .fill(LinearGradient(colors: [.cyan, .blue], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .frame(width: 50, height: 50)
                            .shadow(color: isSpeaking ? .cyan : .clear, radius: isSpeaking ? 10 : 0)
                        
                        if isSpeaking {
                            Image(systemName: "speaker.wave.2.fill")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.white)
                        } else {
                            Image(systemName: "brain.head.profile")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Talk to SARA")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                        Text("🎵 Natural Human Voice AI")
                            .font(.system(size: 16))
                            .foregroundColor(.cyan)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.cyan)
                }
                .padding(.vertical, 18)
                .padding(.horizontal, 25)
                .background(Color.black.opacity(0.4))
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.cyan.opacity(0.5), lineWidth: 1)
                )
                .cornerRadius(15)
            }
            
            // Emergency Protocol Buttons
            VStack(spacing: 15) {
                
                Text("🚨 EMERGENCY PROTOCOLS")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                
                ForEach(EmergencyProtocols.emergencyTypes) { emergency in
                    Button(action: {
                        activateEmergency(emergency.id)
                    }) {
                        EmergencyButton(emergency: emergency)
                    }
                }
            }
            
            Spacer()
            
            // Emergency 911 Button
            Button(action: call911) {
                HStack(spacing: 15) {
                    Image(systemName: "phone.fill")
                        .font(.system(size: 28))
                        .foregroundColor(.white)
                    Text("EMERGENCY 911")
                        .font(.system(size: 22, weight: .bold))
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(Color.red)
                .cornerRadius(15)
                .shadow(color: .red.opacity(0.5), radius: 10)
            }
            
            Spacer()
        }
    }
}

// MARK: - Emergency Button Component

struct EmergencyButton: View {
    let emergency: EmergencyType
    
    var body: some View {
        HStack(spacing: 15) {
            // Icon with video indicator
            ZStack {
                Image(systemName: emergency.icon)
                    .font(.system(size: 28, weight: .semibold))
                    .foregroundColor(.white)
                
                // Video indicator
                Image(systemName: "play.circle.fill")
                    .font(.system(size: 16))
                    .foregroundColor(.orange)
                    .offset(x: 15, y: -15)
            }
            .frame(width: 40)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(emergency.title)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                
                Text(emergency.subtitle + " • Tap for guidance")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.white.opacity(0.8))
            }
            
            Spacer()
        }
        .padding(.vertical, 18)
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity)
        .background(emergency.color == "red" ? Color.red : Color.orange)
        .cornerRadius(12)
        .shadow(color: (emergency.color == "red" ? Color.red : Color.orange).opacity(0.3), radius: 5)
    }
}

// MARK: - SARA View

struct SARAView: View {
    @Binding var showSARA: Bool
    @Binding var saraMessage: String
    let speechManager: SpeechManager
    @Binding var isSpeaking: Bool
    let updateSARAMessage: (String) -> Void
    
    var body: some View {
        VStack(spacing: 25) {
            
            // SARA Header with Enhanced Avatar
            VStack(spacing: 15) {
                // Enhanced SARA Avatar
                ZStack {
                    // Outer glow ring
                    Circle()
                        .fill(Color.clear)
                        .frame(width: 160, height: 160)
                        .overlay(
                            Circle()
                                .stroke(
                                    LinearGradient(colors: [.cyan, .blue], startPoint: .topLeading, endPoint: .bottomTrailing),
                                    lineWidth: 4
                                )
                                .shadow(color: .cyan, radius: isSpeaking ? 20 : 8)
                        )
                    
                    // Main avatar circle
                    Circle()
                        .fill(LinearGradient(colors: [.cyan, .blue], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(width: 140, height: 140)
                        .shadow(color: isSpeaking ? .cyan : .blue, radius: isSpeaking ? 25 : 15)
                        .scaleEffect(isSpeaking ? 1.05 : 1.0)
                        .animation(.easeInOut(duration: 0.5).repeatForever(autoreverses: true), value: isSpeaking)
                    
                    // SARA face representation
                    VStack(spacing: 8) {
                        if isSpeaking {
                            Image(systemName: "speaker.wave.3.fill")
                                .font(.system(size: 50))
                                .foregroundColor(.white)
                        } else {
                            VStack(spacing: 6) {
                                Image(systemName: "brain.head.profile")
                                    .font(.system(size: 40))
                                    .foregroundColor(.white)
                                
                                Image(systemName: "cross.case")
                                    .font(.system(size: 25))
                                    .foregroundColor(.white.opacity(0.8))
                            }
                        }
                    }
                }
                
                Text("SARA")
                    .font(.system(size: 42, weight: .bold))
                    .foregroundColor(.cyan)
                
                Text(isSpeaking ? "Speaking with natural human voice..." : "Natural Human Voice AI Assistant")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(isSpeaking ? .cyan : .white.opacity(0.9))
                
                Text("Enhanced Natural Speech • CODEPLUS")
                    .font(.system(size: 16))
                    .foregroundColor(.cyan.opacity(0.8))
            }
            
            Spacer()
            
            // SARA Chat Interface
            VStack(spacing: 20) {
                
                // SARA Message Bubble
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Circle()
                                .fill(Color.cyan)
                                .frame(width: 10, height: 10)
                            Text("SARA")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.cyan)
                            
                            Spacer()
                            
                            Button(action: {
                                speechManager.speak(saraMessage, emotion: .friendly)
                            }) {
                                Image(systemName: isSpeaking ? "speaker.wave.3.fill" : "speaker.fill")
                                    .font(.system(size: 18))
                                    .foregroundColor(.cyan)
                            }
                        }
                        
                        Text(saraMessage)
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                    }
                    .padding(16)
                    .background(Color.black.opacity(0.4))
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.cyan.opacity(0.3), lineWidth: 1)
                    )
                    .cornerRadius(15)
                    
                    Spacer()
                }
                
                // SARA Quick Actions
                VStack(spacing: 15) {
                    Text("What can I help you with?")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                    
                    SARAActionButton(
                        iconName: "stethoscope",
                        title: "Health Assessment",
                        color: .cyan
                    ) {
                        updateSARAMessage("I'd be happy to help assess your symptoms and guide you to the right care. What symptoms are you experiencing? I'm here to listen.")
                        speechManager.speak("I'd be happy to help assess your symptoms and guide you to the right care. What symptoms are you experiencing? I'm here to listen and support you.", emotion: .caring)
                    }
                    
                    SARAActionButton(
                        iconName: "cross.case.fill",
                        title: "Emergency Guidance",
                        color: .red
                    ) {
                        updateSARAMessage("I'm here to provide immediate emergency guidance with a calm, reassuring voice. What type of emergency are you facing? We'll get through this together.")
                        speechManager.speak("I'm here to provide immediate emergency guidance with a calm, reassuring voice. What type of emergency are you facing? We'll get through this together.", emotion: .calm)
                    }
                    
                    SARAActionButton(
                        iconName: "pills.fill",
                        title: "Medication Help",
                        color: .green
                    ) {
                        updateSARAMessage("I can help with medication questions, interactions, and dosing guidance. What medication question do you have? I'll explain everything clearly.")
                        speechManager.speak("I can help with medication questions, interactions, and dosing guidance. What medication question do you have? I'll explain everything clearly and simply.", emotion: .helpful)
                    }
                    
                    SARAActionButton(
                        iconName: "speaker.wave.3.fill",
                        title: "🎵 Natural Human Voice Demo",
                        color: .purple
                    ) {
                        updateSARAMessage("This is my enhanced, natural human voice! I can speak with warmth and emotion to guide you through emergencies, provide medical advice, and offer caring support during difficult times.")
                        speechManager.speak("This is my enhanced, natural human voice! I can speak with warmth and emotion to guide you through emergencies, provide medical advice, and offer caring support during difficult times. I'm here to help keep your family safe with a voice you can trust.", emotion: .warm)
                    }
                }
            }
            
            Spacer()
            
            // Back Button
            Button(action: {
                showSARA = false
                speechManager.stopSpeaking()
            }) {
                HStack {
                    Image(systemName: "chevron.left")
                    Text("Back to Emergency Protocols")
                        .font(.system(size: 16, weight: .semibold))
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            }
        }
    }
}

// MARK: - SARA Action Button Component

struct SARAActionButton: View {
    let iconName: String
    let title: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 15) {
                Image(systemName: iconName)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(width: 30)
                
                Text(title)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .padding(.horizontal, 20)
            .background(color.opacity(0.8))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(color, lineWidth: 1)
            )
            .cornerRadius(12)
        }
    }
}

// MARK: - Emergency View (Simplified for now)

struct EmergencyView: View {
    let currentProtocol: String
    let stepNumber: Int
    let speechManager: SpeechManager
    @Binding var isSpeaking: Bool
    @Binding var showingEmergencyVideo: Bool
    let getSARAGuidance: () -> String
    let getEmergencyIcon: () -> String
    let getEmergencyInstructions: () -> String
    let getSafetyWarning: () -> String?
    let resolveEmergency: () -> Void
    let nextStep: () -> Void
    let call911: () -> Void
    let resetEmergency: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Emergency View - \(currentProtocol)")
                .font(.title)
                .foregroundColor(.white)
            
            Text("Step \(stepNumber)")
                .font(.headline)
                .foregroundColor(.cyan)
            
            // Add more emergency view content here
            
            Button("Resolve Emergency") {
                resolveEmergency()
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
    }
}

// MARK: - Emergency Video Overlay (Simplified)

struct EmergencyVideoOverlay: View {
    let currentProtocol: String
    let stepNumber: Int
    @Binding var showingEmergencyVideo: Bool
    let speechManager: SpeechManager
    let getSARAGuidance: () -> String
    let getEmergencyInstructions: () -> String
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.9)
                .ignoresSafeArea()
                .onTapGesture {
                    showingEmergencyVideo = false
                }
            
            VStack {
                Text("Video Demo - \(currentProtocol)")
                    .font(.title)
                    .foregroundColor(.white)
                
                Button("Close") {
                    showingEmergencyVideo = false
                }
                .padding()
                .background(Color.gray)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
    }
}
