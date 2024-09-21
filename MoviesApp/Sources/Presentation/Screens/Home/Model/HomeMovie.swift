//
//  HomeMovie.swift
//  MoviesApp
//
//  Created by Leonardo on 9/21/24.
//

import Foundation

struct HomeMovie: Identifiable, Hashable {
    let id = UUID().uuidString
    var movie: Movie
    var isPlaceholder: Bool = false

    static var placeholder: HomeMovie {
        HomeMovie(
            movie: Movie(id: UUID().uuidString, title: "placeholder"),
            isPlaceholder: true
        )
    }
    
    static var sample: HomeMovie {
        HomeMovie(
            movie: Movie(
                id: UUID().uuidString, 
                title: "Deadpool & Wolverine",
                posterPath: "/8cdWjvZQUExUUTzyp4t6EDMubfO.jpg"
            )
        )
    }
}
