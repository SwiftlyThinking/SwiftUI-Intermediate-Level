//
//  EscapingBootcamp.swift
//  SwiftUI-Intermediate-Level
//
//  Created by Mykyta Kuzminov on 09.03.2024.
//

import SwiftUI

class EscapingViewModel: ObservableObject {
    
    @Published var text: String = "Hello!"
    
    func getData() {
        downloadData2 { [weak self] returnedData in
            self?.text = returnedData.title
        }
    }
    
    func downloadData1(completionHandler: @escaping (DownloadResult) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let result = DownloadResult(title: "New data!")
            completionHandler(result)
        }
    }
    
    func downloadData2(completionHandler: @escaping DownloadCompletion) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let result = DownloadResult(title: "New data!")
            completionHandler(result)
        }
    }
}

typealias DownloadCompletion = (DownloadResult) -> ()

struct DownloadResult {
    let title: String
}

struct EscapingBootcamp: View {
    
    @StateObject var vm = EscapingViewModel()
    
    var body: some View {
        Text(vm.text)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundStyle(Color.blue)
            .onTapGesture {
                vm.getData()
            }
    }
}

#Preview {
    EscapingBootcamp()
}
