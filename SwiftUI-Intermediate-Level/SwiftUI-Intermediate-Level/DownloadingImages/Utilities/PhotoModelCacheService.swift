//
//  PhotoModelCacheService.swift
//  SwiftUI-Intermediate-Level
//
//  Created by Mykyta Kuzminov on 12.03.2024.
//

import Foundation
import SwiftUI

class PhotoModelCacheService {
    
    static let shared = PhotoModelCacheService()
    
    private init() {}
    
    var photoCache: NSCache<NSString, UIImage> = {
        var cache = NSCache<NSString, UIImage>()
        cache.countLimit = 200
        cache.totalCostLimit = 1024 * 1024 * 200
        return cache
    }()
    
    func add(image: UIImage, name: String) {
        photoCache.setObject(image, forKey: name as NSString)
    }
    
    func get(name: String) -> UIImage? {
        photoCache.object(forKey: name as NSString)
    }
}
