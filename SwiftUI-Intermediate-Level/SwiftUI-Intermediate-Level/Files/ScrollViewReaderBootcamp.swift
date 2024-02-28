//
//  ScrollViewReaderBootcamp.swift
//  SwiftUI-Intermediate-Level
//
//  Created by Mykyta Kuzminov on 28.02.2024.
//

import SwiftUI

struct ScrollViewReaderBootcamp: View {
    
    @State private var textFieldText = ""
    @State private var scrollToIndex = 0
    
    var body: some View {
        VStack {
            TextField("Enter a number here...", text: $textFieldText)
                .padding(.horizontal)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color(UIColor.secondarySystemBackground))
                .clipShape(.rect(cornerRadius: 10))
                .padding()
                .keyboardType(.numberPad)
            
            Button("Scroll to " + textFieldText) {
                withAnimation(.spring()) {
                    if let index = Int(textFieldText) {
                        scrollToIndex = index
                    }
                }
            }
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .font(.headline)
            .tint(Color.white)
            .background(Color.blue)
            .clipShape(.rect(cornerRadius: 10))
            .padding(.horizontal)
            
            ScrollView {
                ScrollViewReader { proxy in
                    ForEach(0..<30) { index in
                        Text("This is item #\(index)")
                            .font(.headline)
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                            .background(Color(UIColor.secondarySystemBackground))
                            .clipShape(.rect(cornerRadius: 10))
                            .shadow(radius: 2)
                            .padding()
                            .id(index)
                    }
                    .onChange(of: scrollToIndex) {
                        withAnimation(.spring()) {
                            proxy.scrollTo(scrollToIndex, anchor: .top)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ScrollViewReaderBootcamp()
}
