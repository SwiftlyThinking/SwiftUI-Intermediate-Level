//
//  HashableBootcamp.swift
//  SwiftUI-Intermediate-Level
//
//  Created by Mykyta Kuzminov on 04.03.2024.
//

import SwiftUI

struct MyCustomModel: Hashable {
    let title: String
    let subtitle: String
    let count: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title + subtitle)
    }
}

struct HashableBootcamp: View {
    
    let data: [MyCustomModel] = [
        MyCustomModel(title: "One", subtitle: "One", count: 1),
        MyCustomModel(title: "Two", subtitle: "Two", count: 2),
        MyCustomModel(title: "Three", subtitle: "Three", count: 3),
        MyCustomModel(title: "Four", subtitle: "Four", count: 4),
        MyCustomModel(title: "Five", subtitle: "Five", count: 5),
    ]
    
    var body: some View {
        ScrollView {
            ForEach(data, id: \.self) { item in
                VStack {
                    Text(item.title)
                        .font(.title)
                    Text(item.subtitle)
                        .font(.subheadline)
                    Text("\(item.count)")
                        .font(.headline)
                }
            }
        }
    }
}

#Preview {
    HashableBootcamp()
}
