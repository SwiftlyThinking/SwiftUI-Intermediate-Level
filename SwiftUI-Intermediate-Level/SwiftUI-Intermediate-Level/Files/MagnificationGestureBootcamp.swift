//
//  MagnificationGestureBootcamp.swift
//  SwiftUI-Intermediate-Level
//
//  Created by Mykyta Kuzminov on 27.02.2024.
//

import SwiftUI

struct MagnificationGestureBootcamp: View {
    
    @State private var currentAmount: CGFloat = 0
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .frame(height: 300)
            .scaleEffect(1 + currentAmount)
            .gesture(
                MagnificationGesture()
                    .onChanged { value in
                        withAnimation(.default) {
                            currentAmount = value - 1
                        }
                    }
                    .onEnded { value in
                        withAnimation(.default) {
                            currentAmount = 0
                        }
                    }
            )
    }
}

#Preview {
    MagnificationGestureBootcamp()
}
