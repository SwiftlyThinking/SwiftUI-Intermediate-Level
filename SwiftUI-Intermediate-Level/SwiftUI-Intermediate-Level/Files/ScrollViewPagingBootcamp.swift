//
//  ScrollViewPagingBootcamp.swift
//  SwiftUI-Intermediate-Level
//
//  Created by Mykyta Kuzminov on 13.03.2024.
//

import SwiftUI

struct ScrollViewPagingBootcamp: View {
    
    @State private var scrollPosition: Int? = nil
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(0..<10) { index in
                    Rectangle()
                        //.frame(width: 300, height: 300)
                        .overlay {
                            Text("\(index)")
                                .foregroundStyle(Color.white)
                        }
                        .frame(maxWidth: .infinity)
                        .containerRelativeFrame(.vertical, alignment: .center )
                        .id(index)
                        .onTapGesture {
                            withAnimation(.default) {
                                scrollPosition = (0..<10).randomElement()
                            }
                        }
                        .scrollTransition { content, phase in
                            content
                                .opacity(phase.isIdentity ? 1 : 0.5)
                        }
                }
            }
        }
        .ignoresSafeArea()
        .scrollTargetLayout()
        .scrollTargetBehavior(.paging)
        .scrollBounceBehavior(.basedOnSize)
        .scrollPosition(id: $scrollPosition, anchor: .center)
    }
}

#Preview {
    ScrollViewPagingBootcamp()
}
