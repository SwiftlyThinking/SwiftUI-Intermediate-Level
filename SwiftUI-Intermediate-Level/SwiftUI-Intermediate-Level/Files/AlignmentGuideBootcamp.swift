//
//  AlignmentGuideBootcamp.swift
//  SwiftUI-Intermediate-Level
//
//  Created by Mykyta Kuzminov on 13.03.2024.
//

import SwiftUI

struct AlignmentGuideBootcamp: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            row(title: "Row 1", showIcon: false)
            row(title: "Row 2", showIcon: true)
            row(title: "Row 3", showIcon: false)
        }
        .padding(16)
        .background(Color.white)
        .clipShape(.rect(cornerRadius: 10))
        .shadow(radius: 10)
        .padding(40)
    }
    
    private func row(title: String, showIcon: Bool) -> some View {
        HStack {
            if showIcon {
                Image(systemName: "info.circle")
                    .frame(width: 30, height: 30)
            }
            Text(title)
            
            Spacer()
        }
        .alignmentGuide(.leading) { dimensions in
            return showIcon ? 40 : 0
        }
    }
}


#Preview {
    AlignmentGuideBootcamp()
}
