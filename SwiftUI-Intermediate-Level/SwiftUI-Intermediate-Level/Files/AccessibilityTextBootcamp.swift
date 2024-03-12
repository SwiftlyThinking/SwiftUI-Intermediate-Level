//
//  AccessibilityTextBootcamp.swift
//  SwiftUI-Intermediate-Level
//
//  Created by Mykyta Kuzminov on 12.03.2024.
//

import SwiftUI

struct AccessibilityTextBootcamp: View {
    
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(0..<10){ _ in
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Image(systemName: "heart.fill")
//                                .font(.system(size: 20))
                            
                            Text("Welcome to my app")
                                .truncationMode(.tail)
                        }
                        
                        Text("This is some longer text that expands to multiple lines.")
                            .font(.subheadline)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .lineLimit(3)
                            .minimumScaleFactor(dynamicTypeSize.customMinScaleFactor)
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Hello, World!")
        }
    }
}

extension DynamicTypeSize {
    
    var customMinScaleFactor: CGFloat {
        switch self {
        case .small, .medium:
            return 1.0
        case .large, .xLarge, .xxLarge:
            return 0.8
        default:
            return 0.6
        }
    }
    
}

#Preview {
    AccessibilityTextBootcamp()
}
