import Foundation

struct EmergencyProtocols {
    
    // MARK: - SARA Guidance Messages
    
    static func getGuidance(for protocolType: String, step: Int) -> String {
        switch (protocolType, step) {
        case ("Choking", 1):
            return "I'm SARA, and I'm here to guide you through this choking emergency with a calm voice. Take a breath, stay with me, and follow my instructions exactly. We can save this person together. First, let's position yourself behind them."
        case ("Choking", 2):
            return "You're doing great! Now I need you to position your hands correctly. This is really important for the Heimlich maneuver to work effectively. Make a fist and place it just above their belly button."
        case ("Choking", 3):
            return "Perfect positioning! Now we perform the thrusts together. Don't be afraid to use firm pressure, you're saving a life right now. Give quick, sharp upward thrusts."
        case ("Choking", 4):
            return "Keep going! You're doing wonderfully. Continue those thrusts until the object comes out or they start breathing normally. Don't give up, you've got this!"
            
        case ("Heart Attack", 1):
            return "This is SARA with a calm voice. I've detected a possible heart attack. Time is really critical for heart muscle, but we're going to handle this together. Let's act quickly and call 911 immediately."
        case ("Heart Attack", 2):
            return "Excellent work! Now, if you have aspirin available, give it to them. Just make sure they're not allergic first. This can really help prevent further blood clotting."
        case ("Heart Attack", 3):
            return "You're doing wonderfully. Keeping them calm and comfortable really helps reduce the stress on their heart. Have them sit down and rest comfortably."
        case ("Heart Attack", 4):
            return "Stay vigilant with me. I'm monitoring this situation with you. Watch carefully for any changes in their breathing or consciousness."
            
        case ("Stroke", 1):
            return "I'm SARA with my caring voice. Let's do the FAST test together, step by step. First, ask them to smile and watch their face really carefully."
        case ("Stroke", 2):
            return "Good work. Now ask them to raise both arms above their head. Watch closely to see if one arm drifts down."
        case ("Stroke", 3):
            return "Now let's test their speech. Ask them to repeat a simple phrase and listen very carefully to how they sound."
        case ("Stroke", 4):
            return "If any of those signs were present, we need to call 911 immediately. Time is brain tissue, so every minute really counts."
            
        case ("Fall", 1):
            return "I'm SARA with a gentle voice. Let's assess this fall together carefully. First, check if they're conscious and can respond to you."
        case ("Fall", 2):
            return "Good. Now look for any obvious injuries, but don't move them yet if you suspect anything serious."
        case ("Fall", 3):
            return "If you suspect any serious injury, especially to the head or spine, call 911 and keep them completely still."
            
        default:
            return "I'm SARA, your caring AI medical assistant. I'm here to guide you through this emergency step by step with my voice. You can absolutely do this."
        }
    }
    
    // MARK: - Emergency Instructions
    
    static func getInstructions(for protocolType: String, step: Int) -> String {
        switch (protocolType, step) {
        
        // CHOKING PROTOCOL
        case ("Choking", 1):
            return """
            Stand directly behind the choking person.
            Wrap your arms around their waist from behind.
            Make sure you have stable footing.
            """
        case ("Choking", 2):
            return """
            Make a fist with one hand.
            Place the thumb side just above their belly button.
            Keep your fist below the ribcage.
            """
        case ("Choking", 3):
            return """
            Grasp your fist with your other hand.
            Give quick, forceful upward thrusts.
            Pull sharply inward and upward.
            Use firm pressure!
            """
        case ("Choking", 4):
            return """
            Keep giving thrusts until object comes out.
            Watch for the person to start breathing normally.
            If they become unconscious, start CPR immediately.
            """
        
        // HEART ATTACK PROTOCOL
        case ("Heart Attack", 1):
            return """
            Don't wait or hesitate!
            Don't drive to hospital yourself.
            Emergency responders have life-saving equipment.
            Time is critical for heart muscle.
            """
        case ("Heart Attack", 2):
            return """
            Give 325mg aspirin if available.
            Only if person is NOT allergic.
            Have them chew it, don't swallow whole.
            This helps prevent blood clots.
            """
        case ("Heart Attack", 3):
            return """
            Have person sit down and rest.
            Loosen any tight clothing.
            Keep them calm and reassured.
            Don't let them walk around.
            """
        case ("Heart Attack", 4):
            return """
            Watch their breathing continuously.
            Be ready to start CPR if they become unconscious.
            Note any changes in their condition.
            Stay with them until help arrives.
            """
        
        // STROKE PROTOCOL
        case ("Stroke", 1):
            return """
            Ask the person to smile.
            Look carefully at their face.
            Does one side droop?
            Is their smile uneven or lopsided?
            """
        case ("Stroke", 2):
            return """
            Ask person to raise both arms above head.
            Watch them carefully.
            Does one arm drift down?
            Can they keep both arms up equally?
            """
        case ("Stroke", 3):
            return """
            Ask them to repeat a simple phrase.
            Listen carefully to their speech.
            Is it slurred, garbled, or strange?
            Do they understand what you're saying?
            """
        case ("Stroke", 4):
            return """
            If ANY signs are present, call 911 NOW!
            Note the exact time symptoms started.
            This is critical for treatment decisions.
            Every minute counts for brain tissue!
            """
        
        // FALL PROTOCOL
        case ("Fall", 1):
            return """
            Ask if they're okay and can hear you.
            Check if they know their name and location.
            Look for signs of confusion.
            Don't move them yet!
            """
        case ("Fall", 2):
            return """
            Look for obvious bleeding or injuries.
            Check for unusual positioning of limbs.
            Ask where they feel pain.
            Don't move them if you suspect serious injury.
            """
        case ("Fall", 3):
            return """
            If serious injury suspected, call 911.
            Don't move someone with possible spinal injury.
            Keep them still and warm.
            Monitor breathing until help arrives.
            """
        
        default:
            return "SARA is guiding you through this emergency protocol. Follow instructions step by step."
        }
    }
    
    // MARK: - Safety Warnings
    
    static func getSafetyWarning(for protocolType: String, step: Int) -> String? {
        switch (protocolType, step) {
        case ("Choking", 2): return "Keep hands below ribcage to avoid injury"
        case ("Choking", 3): return "Use firm pressure - don't be afraid to use force"
        case ("Heart Attack", 2): return "Only give aspirin if person is NOT allergic"
        case ("Stroke", 4): return "Time is brain - every minute of delay matters"
        case ("Fall", 2): return "Never move someone with suspected spinal injury"
        default: return nil
        }
    }
    
    // MARK: - Protocol Configuration
    
    static func getMaxSteps(for protocolType: String) -> Int {
        switch protocolType {
        case "Choking": return 4
        case "Heart Attack": return 4
        case "Stroke": return 4
        case "Fall": return 3
        default: return 1
        }
    }
    
    static func getIcon(for protocolType: String) -> String {
        switch protocolType {
        case "Choking": return "lungs.fill"
        case "Heart Attack": return "heart.fill"
        case "Stroke": return "brain.head.profile"
        case "Fall": return "figure.fall"
        default: return "cross.case.fill"
        }
    }
    
    // MARK: - Emergency Types
    
    static let emergencyTypes = [
        EmergencyType(
            id: "Choking",
            icon: "lungs.fill",
            title: "CHOKING EMERGENCY",
            subtitle: "Can't breathe, cough, or speak",
            color: "red"
        ),
        EmergencyType(
            id: "Heart Attack",
            icon: "heart.fill",
            title: "HEART ATTACK",
            subtitle: "Chest pain, shortness of breath",
            color: "red"
        ),
        EmergencyType(
            id: "Stroke",
            icon: "brain.head.profile",
            title: "STROKE",
            subtitle: "Face drooping, speech problems",
            color: "red"
        ),
        EmergencyType(
            id: "Fall",
            icon: "figure.fall",
            title: "SERIOUS FALL",
            subtitle: "Head injury, can't get up",
            color: "orange"
        )
    ]
}

// MARK: - Data Models

struct EmergencyType: Identifiable {
    let id: String
    let icon: String
    let title: String
    let subtitle: String
    let color: String
}
