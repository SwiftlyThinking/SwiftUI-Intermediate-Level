//
//  CacheBootcamp.swift
//  SwiftUI-Intermediate-Level
//
//  Created by Mykyta Kuzminov on 11.03.2024.
//

import SwiftUI

class CacheManager {
    
    static let shared = CacheManager()
    private init() {}
    
    var imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100
        return cache
    }()
    
    func add(image: UIImage, name: String) {
        imageCache.setObject(image, forKey: name as NSString)
    }
    
    func remove(image name: String) {
        imageCache.removeObject(forKey: name as NSString)
    }
    
    func get(image name: String) -> UIImage? {
        imageCache.object(forKey: name as NSString)
    }
}

class CacheViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    
    private var cacheManager = CacheManager.shared
    private var imageName: String = "image"
    
    init() {
        getImage()
    }
    
    func getImage() {
        image = cacheManager.get(image: imageName)
    }
    
    func saveImage() {
        guard let image = UIImage(named: imageName) else { return }
        cacheManager.add(image: image, name: imageName)
        getImage()
    }
    
    func deleteImage() {
        cacheManager.remove(image: imageName)
        getImage()
    }
    
}

struct CacheBootcamp: View {
    
    @StateObject private var vm = CacheViewModel()
    
    var body: some View {
        VStack {
            
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 300, height: 300)
            } else {
                ProgressView()
            }
            
            Spacer()
            
            HStack {
                Button {
                    vm.saveImage()
                } label: {
                    Text("Save")
                        .font(.headline)
                        .padding()
                        .frame(width: 150, height: 55)
                        .background(Color(UIColor.secondarySystemFill))
                        .clipShape(.rect(cornerRadius: 10))
                }
                
                Button {
                    vm.deleteImage()
                } label: {
                    Text("Delete")
                        .font(.headline)
                        .padding()
                        .frame(width: 150, height: 55)
                        .background(Color(UIColor.secondarySystemFill))
                        .clipShape(.rect(cornerRadius: 10))
                }
            }
            .padding()
        }
    }
}

#Preview {
    CacheBootcamp()
}
