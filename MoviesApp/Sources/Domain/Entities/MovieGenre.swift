//
//  MovieGenre.swift
//  MoviesApp
//
//  Created by Leonardo on 9/22/24.
//

import Foundation

struct MovieGenre: Identifiable, Hashable {
    let id: String
    var name: String
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
    
    static var sample: MovieGenre {
        MovieGenre(id: UUID().uuidString, name: "Action")
    }
}
