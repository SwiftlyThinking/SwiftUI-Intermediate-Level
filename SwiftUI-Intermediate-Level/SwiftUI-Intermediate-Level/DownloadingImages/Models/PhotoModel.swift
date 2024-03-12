//
//  PhotoModel.swift
//  SwiftUI-Intermediate-Level
//
//  Created by Mykyta Kuzminov on 12.03.2024.
//

import Foundation

struct PhotoModel: Identifiable, Codable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
