//
//  Movie.swift
//  MoviesApp
//
//  Created by Leonardo on 9/21/24.
//

import Foundation

struct Movie: Identifiable, Hashable {
    var id: String
    var title: String?
    var posterPath: String?

    init(id: String, title: String? = nil, posterPath: String? = nil) {
        self.id = id
        self.title = title
        self.posterPath = posterPath
    }

    var posterURL: URL? {
        guard let posterPath else { return nil }
        let path = "https://image.tmdb.org/t/p/w300" + posterPath
        return URL(string: path)
    }
}
