//
//  WeakSelfBootcamp.swift
//  SwiftUI-Intermediate-Level
//
//  Created by Mykyta Kuzminov on 09.03.2024.
//

import SwiftUI

struct WeakSelfBootcamp: View {
    
    @AppStorage("int") var amount: Int = 0
    
    var body: some View {
        NavigationStack {
            NavigationLink("Navigate") {
                WeakSelfSecondScreen()
            }
        }
        .overlay(
            Text("\(amount)")
                .font(.largeTitle)
                .padding()
                .background(Color.green)
                .clipShape(.rect(cornerRadius: 10))
            , alignment: .bottom
        )
    }
}

struct WeakSelfSecondScreen: View {
    
    @StateObject private var vm = WeakSelfViewModel()
    
    var body: some View {
        Text(vm.data ?? "")
            .font(.title)
            .fontWeight(.bold)
            .foregroundStyle(Color.blue)
    }
}

class WeakSelfViewModel: ObservableObject {
    
    @Published var data: String? = nil
    
    init() {
        print("Initialize now!")
        let currentCount = UserDefaults.standard.integer(forKey: "int")
        UserDefaults.standard.set(currentCount + 1, forKey: "int")
        getData()
    }
    
    deinit {
        print("Deinitialize now!")
        let currentCount = UserDefaults.standard.integer(forKey: "int")
        UserDefaults.standard.set(currentCount - 1, forKey: "int")
    }
    
    func getData() {
    DispatchQueue.global().asyncAfter(deadline: .now() + 100) { [weak self] in
            self?.data = "Second Screen"
        }
    }
}

#Preview {
    WeakSelfBootcamp()
}
