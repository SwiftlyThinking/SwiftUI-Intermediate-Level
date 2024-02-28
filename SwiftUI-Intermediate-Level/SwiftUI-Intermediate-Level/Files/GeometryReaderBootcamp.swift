//
//  GeometryReaderBootcamp.swift
//  SwiftUI-Intermediate-Level
//
//  Created by Mykyta Kuzminov on 28.02.2024.
//

import SwiftUI

struct GeometryReaderBootcamp: View {
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(0..<20) { index in
                    GeometryReader { proxy in
                        RoundedRectangle(cornerRadius: 20)
                            .rotation3DEffect(
                                .degrees(getPercentage(proxy: proxy) * 20),
                                axis: (x: 0.0, y: 1.0, z: 0.0)
                            )
                    }
                    .frame(width: 300, height: 250)
                    .padding()
                }
            }
        }
        .scrollIndicators(.hidden)
    }
    
    private func getPercentage(proxy: GeometryProxy) -> Double {
        let maxWidth = UIScreen.main.bounds.width / 2
        let currentX = proxy.frame(in: .global).midX
        return Double(1 - (currentX / maxWidth))
    }
}

#Preview {
    GeometryReaderBootcamp()
}
