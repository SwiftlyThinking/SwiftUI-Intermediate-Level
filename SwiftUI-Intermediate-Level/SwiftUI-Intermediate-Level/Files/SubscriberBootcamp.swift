//
//  SubscriberBootcamp.swift
//  SwiftUI-Intermediate-Level
//
//  Created by Mykyta Kuzminov on 10.03.2024.
//

import SwiftUI
import Combine

class SubscriberViewModel: ObservableObject {
    
    @Published var count: Int = 0
    @Published var textFieldText: String = ""
    @Published var isTextValid: Bool = false
    @Published var showButton: Bool = false
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        setUpTimer()
        addTextFieldSubscriber()
        addButtonSubscriber()
    }
    
    func setUpTimer() {
        Timer
            .publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.count += 1
                
//                if self.count >= 10 {
//                    for item in cancellables {
//                        item.cancel()
//                    }
//                }
            }
            .store(in: &cancellables)
    }
    
    func addTextFieldSubscriber() {
        $textFieldText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(isValidTextFunc)
            .sink { [weak self] returnedValue in
                self?.isTextValid = returnedValue
            }
            .store(in: &cancellables)
    }
    
    func addButtonSubscriber() {
        $isTextValid
            .combineLatest($count)
            .sink { [weak self] isValid, count in
                guard let self = self else { return }
                if isValid && count >= 10 {
                    self.showButton = true
                } else {
                    self.showButton = false
                }
            }
            .store(in: &cancellables)
    }
    
    func isValidTextFunc(text: String) -> Bool {
        var result = false
        result = text.count > 3 ? true : false
        return result
    }
}

struct SubscriberBootcamp: View {
    
    @StateObject private var vm = SubscriberViewModel()
    
    var body: some View {
        VStack {
            Text("\(vm.count)")
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            TextField("Some text here...", text: $vm.textFieldText)
                .fontWeight(.semibold)
                .padding(.horizontal)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color(UIColor.secondarySystemFill))
                .clipShape(.rect(cornerRadius: 10))
                .padding(.horizontal)
                .overlay (
                    Image(systemName: vm.isTextValid ? "checkmark" : "xmark")
                        .font(.title2)
                        .foregroundStyle(vm.isTextValid ? Color.green : Color.red )
                        .padding(.trailing, 30)
                    , alignment: .trailing
                )
            
            Button {
                // Some code here...
            } label: {
                Text("Save")
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.white)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(vm.showButton ? Color(UIColor.blue) : Color(UIColor.blue).opacity(0.3))
                    .clipShape(.rect(cornerRadius: 10))
                    .padding(.horizontal)
            }
        }
    }
}

#Preview {
    SubscriberBootcamp()
}
