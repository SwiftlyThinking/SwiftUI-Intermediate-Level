//
//  TimerBootcamp.swift
//  SwiftUI-Intermediate-Level
//
//  Created by Mykyta Kuzminov on 10.03.2024.
//

import SwiftUI

struct TimerBootcamp: View {
    
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
    @State private var count: Int = 0
    @State private var date: Date = Date()
    @State private var amount: Int = 10
    @State private var text: String? = nil
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        return formatter
    }
    
    var body: some View {
        ZStack {
            RadialGradient(
                colors: [Color.purple, Color.blue],
                center: .center,
                startRadius: 5,
                endRadius: 500)
            .ignoresSafeArea()
            
            VStack {
                HStack {
                    Circle()
                        .offset(y: count == 1 ? -20 : 0)
                    Circle()
                        .offset(y: count == 2 ? -20 : 0)
                    Circle()
                        .offset(y: count == 3 ? -20 : 0)
                }
                .foregroundStyle(Color.white)
                .frame(width: 100, height: 100)
                
                Text(dateFormatter.string(from: date))
                    .font(.system(size: 50, weight: .semibold, design: .rounded))
                    .foregroundStyle(Color.white)
                
                Text(text ?? "\(amount)")
                    .font(.system(size: 50, weight: .semibold, design: .rounded))
                    .foregroundStyle(Color.white)
            }
        }
        .onReceive(timer) { _ in
            withAnimation(.spring(
                response: 1.0,
                dampingFraction: 1.0,
                blendDuration: 1.0)) {
                    count = count == 3 ? 0 : count + 1
                }
        }
        .onReceive(timer) { value in
            date = value
        }
        .onReceive(timer) { _ in
            if amount < 1 {
                text = "Wow!"
            } else {
                amount -= 1
            }
        }
    }
}

#Preview {
    TimerBootcamp()
}
