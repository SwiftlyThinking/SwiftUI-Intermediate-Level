//
//  BackgroundThreadBootcamp.swift
//  SwiftUI-Intermediate-Level
//
//  Created by Mykyta Kuzminov on 09.03.2024.
//

import SwiftUI

@Observable class BackgroundThreadViewModel {
    
    var dataArray: [String] = []
    
    func getData() {
        DispatchQueue.global().async {
            let newData = self.downloadData()
            
            DispatchQueue.main.async {
                self.dataArray = newData
            }
        }
    }
    
    private func downloadData() -> [String] {
        var data: [String] = []
        for x in 0...100 {
            data.append("\(x)")
        }
        return data
    }
}

struct BackgroundThreadBootcamp: View {
    
    @State private var vm = BackgroundThreadViewModel()
    
    var body: some View {
        VStack {
            Button {
                vm.getData()
            } label: {
                Text("Download")
                    .fontWeight(.bold)
            }
            
            ScrollView {
                ForEach(vm.dataArray, id: \.self) { string in
                   Text(string)
                        .foregroundStyle(Color.green)
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    BackgroundThreadBootcamp()
}
