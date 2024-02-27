//
//  DragGestureBootcamp.swift
//  SwiftUI-Intermediate-Level
//
//  Created by Mykyta Kuzminov on 27.02.2024.
//

import SwiftUI

struct DragGestureBootcamp: View {
    
    @State private var offset: CGSize = .zero

    var body: some View {
        Rectangle()
            .frame(width: 300, height: 500)
            .rotationEffect(.degrees(getRotateAmount()))
            .scaleEffect(getScaleAmount())
            .offset(offset)
            .shadow(color: getColor(), radius: 10)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        withAnimation(.default) {
                            offset = value.translation
                        }
                    }
                    .onEnded { value in
                        withAnimation(.default) {
                            offset = .zero
                        }
                    }
            )
    }
    
    private func getScaleAmount() -> CGFloat {
        let maxWidth = UIScreen.main.bounds.width / 2
        let currentOffset = abs(offset.width)
        let percentage = currentOffset / maxWidth
        return 1.0 - min(percentage, 0.5) * 0.5
    }
    
    private func getRotateAmount() -> Double {
        let maxWidth = UIScreen.main.bounds.width / 2
        let currentOffset = offset.width
        let percentage = Double(currentOffset / maxWidth)
        return percentage * 10
    }
    
    private func getColor() -> Color {
        let currentOffset = offset.width
        var color = Color.clear
        if currentOffset < 0 {
            color = Color(UIColor.orange)
        } else if currentOffset > 0 {
            color = Color(UIColor.green)
        } else {
            
        }
        return color
    }
}

#Preview {
    DragGestureBootcamp()
}
