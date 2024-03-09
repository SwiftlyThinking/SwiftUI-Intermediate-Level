//
//  TypealiasBootcamp.swift
//  SwiftUI-Intermediate-Level
//
//  Created by Mykyta Kuzminov on 09.03.2024.
//

import SwiftUI

struct MovieModel: Hashable {
    let title: String
    let director: String
    let viewers: Int
}

typealias TVModel = MovieModel

struct TypealiasBootcamp: View {
    
    @State var movies = [
        MovieModel(title: "Movie 1", director: "Nick", viewers: 100),
        MovieModel(title: "Movie 2", director: "Sarah", viewers: 200),
        MovieModel(title: "Movie 3", director: "John", viewers: 300),
    ]
    
    @State var tvShows = [
        TVModel(title: "TV Show 1", director: "Andrew", viewers: 300),
        TVModel(title: "TV Show 2", director: "Robert", viewers: 600),
        TVModel(title: "TV Show 3", director: "William", viewers: 900),
    ]
    
    var body: some View {
        VStack(spacing: 30) {
            HStack {
                ForEach(movies, id: \.self) { movie in
                    VStack {
                        Text(movie.title)
                        Text(movie.director)
                        Text("\(movie.viewers)")
                    }
                }
            }
            
            HStack {
                ForEach(tvShows, id: \.self) { show in
                    VStack {
                        Text(show.title)
                        Text(show.director)
                        Text("\(show.viewers)")
                    }
                }
            }
        }
    }
}

#Preview {
    TypealiasBootcamp()
}
