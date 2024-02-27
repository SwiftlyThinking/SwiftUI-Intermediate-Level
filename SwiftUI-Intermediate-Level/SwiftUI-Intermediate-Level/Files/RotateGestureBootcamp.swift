//
//  RotationGestureBootcamp.swift
//  SwiftUI-Intermediate-Level
//
//  Created by Mykyta Kuzminov on 27.02.2024.
//

import SwiftUI

struct RotateGestureBootcamp: View {
    
    @State private var angle: Angle = .degrees(0)
    
    var body: some View {
        Rectangle()
            .frame(width: 200, height: 200)
            .rotationEffect(angle)
            .gesture(
                RotateGesture()
                    .onChanged { value in
                        withAnimation(.default) {
                            angle = value.rotation
                        }
                    }
                    .onEnded { value in
                        withAnimation(.default) {
                            angle = .degrees(0)
                        }
                    }
            )
    }
}

#Preview {
    RotateGestureBootcamp()
}
