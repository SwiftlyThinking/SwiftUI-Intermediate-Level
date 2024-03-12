//
//  DownloadingImagesBootcamp.swift
//  SwiftUI-Intermediate-Level
//
//  Created by Mykyta Kuzminov on 12.03.2024.
//

import SwiftUI

struct DownloadingImagesBootcamp: View {
    
    @StateObject var vm = DownloadingImagesViewModel()
    
    var body: some View {
        List {
            ForEach(vm.models, id: \.id) { model in
                DownloadingImagesRow(model: model)
            }
        }
    }
}

#Preview {
    DownloadingImagesBootcamp()
}
