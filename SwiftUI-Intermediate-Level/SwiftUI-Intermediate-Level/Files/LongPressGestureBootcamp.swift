//
//  LongPressGestureBootcamp.swift
//  SwiftUI-Intermediate-Level
//
//  Created by Mykyta Kuzminov on 26.02.2024.
//

import SwiftUI

struct LongPressGestureBootcamp: View {
    
    @State private var isComplete: Bool = false
    @State private var isSuccess: Bool = false
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(isSuccess ? Color.green : Color.blue)
                .frame(height: 55)
                .frame(width: isComplete ? .infinity : 0)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.gray)
            
            HStack {
                Text("Hold")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.black)
                    .padding()
                    .frame(width: 100, height: 55)
                    .background(Color.green)
                    .clipShape(.rect(cornerRadius: 20))
                    .onLongPressGesture(minimumDuration: 2.0, maximumDistance: 50) {
                        withAnimation(.easeInOut) {
                            isSuccess = true
                        }
                    } onPressingChanged: { isPressing in
                        if isPressing {
                            withAnimation(.easeInOut(duration: 2.0)) {
                                isComplete = true
                            }
                        } else {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                if !isSuccess {
                                    withAnimation(.easeInOut) {
                                        isComplete = false
                                    }
                                }
                            }
                        }
                    }

                
                Button {
                    withAnimation(.easeInOut) {
                        isComplete = false
                        isSuccess = false
                    }
                } label: {
                    Text("Reset")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.black)
                        .padding()
                        .frame(width: 100, height: 55)
                        .background(Color.red)
                        .clipShape(.rect(cornerRadius: 20))
                }
            }
            
        }
    }
}

#Preview {
    LongPressGestureBootcamp()
}
