//
//  MultipleSheetsBootcamp.swift
//  SwiftUI-Intermediate-Level
//
//  Created by Mykyta Kuzminov on 29.02.2024.
//

import SwiftUI

struct RandomModel: Identifiable {
    let id: String = UUID().uuidString
    let title: String
}

struct MultipleSheetsBootcamp: View {
    
    @State var selectedModel: RandomModel? = nil
    
    var body: some View {
        VStack {
            ForEach(0..<10) { index in
                Button("Button #\(index)") {
                    selectedModel = RandomModel(title: "\(index)")
                }
            }
        }
        .sheet(item: $selectedModel) { model in
            NextScreen(title: model.title)
        }
    }
}

struct NextScreen: View {
    
    let title: String
    
    var body: some View {
        Text(title)
            .font(.largeTitle)
            .fontWeight(.semibold)
    }
}

#Preview {
    MultipleSheetsBootcamp()
}
