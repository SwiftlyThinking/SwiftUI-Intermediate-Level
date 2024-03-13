//
//  VisualEffectBootcamp.swift
//  SwiftUI-Intermediate-Level
//
//  Created by Mykyta Kuzminov on 13.03.2024.
//

import SwiftUI

struct VisualEffectBootcamp: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                ForEach(0..<100) { index in
                    Rectangle()
                        .frame(width: 300, height: 200)
                        .frame(maxWidth: .infinity)
                        .background(Color.orange)
                        .visualEffect { content, geometryProxy in
                            content
                                .offset(x: geometryProxy.frame(in: .global).minY * 0.05)
                        }
                }
            }
        }
    }
}

#Preview {
    VisualEffectBootcamp()
}
