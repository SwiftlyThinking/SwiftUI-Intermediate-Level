//
//  HapticsBootcamp.swift
//  SwiftUI-Intermediate-Level
//
//  Created by Mykyta Kuzminov on 01.03.2024.
//

import SwiftUI

class HapticManager {
    
    static let instance = HapticManager()
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}

struct HapticsBootcamp: View {
    var body: some View {
        VStack(spacing: 20) {
            Button("Success") { HapticManager.instance.notification(type: .success) }
            Button("Warning") { HapticManager.instance.notification(type: .warning) }
            Button("Error") { HapticManager.instance.notification(type: .error) }
            Divider()
            Button("Heavy") { HapticManager.instance.impact(style: .heavy) }
            Button("Soft") { HapticManager.instance.impact(style: .soft) }
            Button("Light") { HapticManager.instance.impact(style: .light) }
            Button("Medium") { HapticManager.instance.impact(style: .medium) }
            Button("Rigid") { HapticManager.instance.impact(style: .rigid) }
        }
    }
}

#Preview {
    HapticsBootcamp()
}
