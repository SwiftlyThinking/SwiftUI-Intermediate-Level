//
//  ArraysBootcamp.swift
//  SwiftUI-Intermediate-Level
//
//  Created by Mykyta Kuzminov on 04.03.2024.
//

import SwiftUI

struct UserModel: Identifiable {
    let id: String = UUID().uuidString
    let username: String
    let points: Int
    let isVerified: Bool
}

class ArrayViewModel: ObservableObject {
    
    @Published var data: [UserModel] = []
    @Published var names: [String] = []
    
    init() {
        getData()
        filterData()
        mapData()
    }
    
    func getData() {
        let user1 = UserModel(username: "Mykyta", points: 10, isVerified: true)
        let user2 = UserModel(username: "Andrew", points: 20, isVerified: false)
        let user3 = UserModel(username: "Kostya", points: 5, isVerified: false)
        let user4 = UserModel(username: "Alex", points: 5, isVerified: true)
        
        data.append(contentsOf: [user1, user2, user3, user4])
    }
    
    func sortData() {
        data.sort(by: { $0.points > $1.points } )
    }
    
    func filterData() {
        let data = data.filter( { $0.isVerified } )
        self.data = data
    }
    
    func mapData() {
        let data = data.map( { $0.username } )
        names = data
    }
    
}

struct ArraysBootcamp: View {
    
    @StateObject var vm = ArrayViewModel()
    
    var body: some View {
        ScrollView {
            ForEach(vm.data) { user in
                HStack {
                    Text(user.username)
                        .frame(width: 100, alignment: .leading)
                    
                    Spacer()
                    
                    Text("\(user.points)")
                        .frame(width: 100, alignment: .leading)
                    
                    Spacer()
                    Image(systemName: user.isVerified ? "checkmark" : "xmark")
                        .foregroundStyle(user.isVerified ? .green : .red)
                }
                .padding()
            }
            
            ForEach(vm.names, id: \.self) { name in
                Text(name)
            }
        }
    }
}

#Preview {
    ArraysBootcamp()
}
