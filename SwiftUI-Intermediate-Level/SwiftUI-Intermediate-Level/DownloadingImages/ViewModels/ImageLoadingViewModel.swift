//
//  ImageLoadingViewModel.swift
//  SwiftUI-Intermediate-Level
//
//  Created by Mykyta Kuzminov on 12.03.2024.
//

import Foundation
import SwiftUI
import Combine

class ImageLoadingViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    let url: String
    let name: String
    
    private var cacheManager = PhotoModelCacheService.shared
    
    var cancellables = Set<AnyCancellable>()
    
    init(url: String, name: String) {
        self.url = url
        self.name = name
        getImage()
    }
    
    func getImage() {
        if let savedImage = cacheManager.get(name: name) {
            image = savedImage
            print("Getting saved image!")
        } else {
            downloadImage()
            print("Downloading image now!")
        }
    }
    
    func downloadImage() {
        isLoading = true
        guard let url = URL(string: url) else {
            isLoading = false
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] returnedImage in
                guard
                    let self = self,
                    let image = returnedImage
                else { return }
                
                self.image = image
                self.cacheManager.add(image: image, name: name)
            }
            .store(in: &cancellables)
    }
}
