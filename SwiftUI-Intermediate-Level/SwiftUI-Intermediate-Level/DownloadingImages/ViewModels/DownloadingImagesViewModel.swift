//
//  DownloadingImagesViewModel.swift
//  SwiftUI-Intermediate-Level
//
//  Created by Mykyta Kuzminov on 12.03.2024.
//

import Foundation
import Combine

class DownloadingImagesViewModel: ObservableObject {
    
    @Published var models: [PhotoModel] = []
    
    private var dataManager = PhotoModelDataService.shared
    
    var cancellabels = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        dataManager.$returnedData
            .sink { [weak self] returnedData in
                self?.models = returnedData
            }
            .store(in: &cancellabels)
    }
    
}
