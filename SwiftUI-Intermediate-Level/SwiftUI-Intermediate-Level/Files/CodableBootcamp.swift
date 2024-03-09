//
//  CodableBootcamp.swift
//  SwiftUI-Intermediate-Level
//
//  Created by Mykyta Kuzminov on 09.03.2024.
//

import SwiftUI

struct PlayerModel: Codable {
    let name: String
    let points: Int
}

class CodableViewModel: ObservableObject {
    
    @Published var player: PlayerModel? = nil
    
    func encode() -> Data? {
        let player = PlayerModel(name: "Nick", points: 25)
        let jsonData = try? JSONEncoder().encode(player)
        return jsonData
    }
    
    func decode(data: Data?) {
        guard let data = data else { return }
        let decodedData = try? JSONDecoder().decode(PlayerModel.self, from: data)
        player = decodedData
    }
}

struct CodableBootcamp: View {
    
    @StateObject private var vm = CodableViewModel()
    
    var body: some View {
        VStack {
            Text(vm.player?.name ?? "No name")
            Text("\(vm.player?.points ?? 0)")
        }
        .font(.title)
        .fontWeight(.semibold)
        .foregroundStyle(Color.white)
        .padding()
        .background(Color.blue)
        .clipShape(.rect(cornerRadius: 10))
        .onAppear {
            let jsonData = vm.encode()
            vm.decode(data: jsonData)
        }
    }
}

#Preview {
    CodableBootcamp()
}
