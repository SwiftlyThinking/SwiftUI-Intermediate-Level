//
//  AccessibilityColorsBootcamp.swift
//  SwiftUI-Intermediate-Level
//
//  Created by Mykyta Kuzminov on 12.03.2024.
//

import SwiftUI

struct AccessibilityColorsBootcamp: View {
    
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency
    @Environment(\.colorSchemeContrast) var colorSchemeContrast
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityInvertColors) var invertColors
    
    var body: some View {
        VStack {
            Button("Button #1") {
                
            }
            .foregroundStyle(colorSchemeContrast == .increased ? .white : .primary)
            .buttonStyle(BorderedProminentButtonStyle())
            
            Button("Button #2") {
                
            }
            .foregroundStyle(.primary)
            .buttonStyle(BorderedProminentButtonStyle())
            .tint(.orange)
            
            Button("Button #3") {
                
            }
            .foregroundStyle(.primary)
            .buttonStyle(BorderedProminentButtonStyle())
            .foregroundStyle(Color.white)
            .tint(.green)
            
            Button("Button #4") {
                
            }
            .foregroundStyle(.primary)
            .buttonStyle(BorderedProminentButtonStyle())
            .foregroundStyle(Color.green)
            .tint(differentiateWithoutColor ? .black : .purple)
        }
        .font(.largeTitle)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(reduceTransparency ? Color.black : Color.gray)
    }
}

#Preview {
    AccessibilityColorsBootcamp()
}
