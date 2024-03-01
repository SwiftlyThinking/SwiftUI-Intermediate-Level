//
//  MaskBootcamp.swift
//  SwiftUI-Intermediate-Level
//
//  Created by Mykyta Kuzminov on 01.03.2024.
//

import SwiftUI

struct MaskBootcamp: View {
    
    @State var rating: Int = 3
    
    var body: some View {
        ZStack {
            starsView
                .overlay(overlayView.mask(starsView))
        }
    }
    
    private var starsView: some View {
        HStack {
            ForEach(1..<6) { index in
                Image(systemName: "star.fill")
                    .font(.largeTitle)
                    .foregroundStyle(rating >= index ? Color.yellow : Color.gray)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            rating = index
                        }
                    }
            }
        }
    }
    
    private var overlayView: some View {
        GeometryReader { proxy in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundStyle(Color.yellow)
                    .frame(width: CGFloat(rating) / 5 * proxy.size.width)
            }
        }
        .allowsHitTesting(false)
    }
}

#Preview {
    MaskBootcamp()
}
