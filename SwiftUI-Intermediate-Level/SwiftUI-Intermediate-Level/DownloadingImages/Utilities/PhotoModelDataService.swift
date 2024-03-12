//
//  PhotoModelDataService.swift
//  SwiftUI-Intermediate-Level
//
//  Created by Mykyta Kuzminov on 12.03.2024.
//

import Foundation
import Combine

class PhotoModelDataService {
    
    static let shared = PhotoModelDataService()
    
    @Published var returnedData: [PhotoModel] = []
    
    var cancellables = Set<AnyCancellable>()
    
    private init() {
        downloadData()
    }
    
    func downloadData() {
        
        guard 
            let url = URL(string: "https://jsonplaceholder.typicode.com/photos")
        else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [PhotoModel].self, decoder: JSONDecoder())
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error downloading data. \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] returnedData in
                self?.returnedData = returnedData
            }
            .store(in: &cancellables)

    }
    
    private func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300
        else {
            throw URLError(.badServerResponse)
        }
        
        return output.data
    }
    
}
