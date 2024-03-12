//
//  DownloadingImageView.swift
//  SwiftUI-Intermediate-Level
//
//  Created by Mykyta Kuzminov on 12.03.2024.
//

import SwiftUI

struct DownloadingImageView: View {
    
    @StateObject var vm: ImageLoadingViewModel
    
    init(url: String, name: String) {
        _vm = StateObject(wrappedValue: ImageLoadingViewModel(url: url, name: name))
    }
    
    var body: some View {
        if vm.isLoading {
            ProgressView()
        } else if let image = vm.image {
                Image(uiImage: image)
                .resizable()
                .clipShape(Circle())
        }
    }
}

#Preview {
    DownloadingImageView(url: "https://via.placeholder.com/600/92c952", name: "1")
}
