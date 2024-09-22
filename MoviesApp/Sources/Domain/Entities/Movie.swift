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
    var voteAverage: Double?
    var releaseDate: String?

    init(id: String, title: String? = nil, posterPath: String? = nil, voteAverage: Double?, releaseDate: String? = nil) {
        self.id = id
        self.title = title
        self.posterPath = posterPath
        self.voteAverage = voteAverage
        self.releaseDate = releaseDate
    }

    static var sample: Movie {
        Movie(
            id: UUID().uuidString,
            title: "Spiderman",
            posterPath: "/8cdWjvZQUExUUTzyp4t6EDMubfO.jpg",
            voteAverage: 7.5,
            releaseDate: "2020-03-22"
        )
    }

    var posterURL: URL? {
        guard let posterPath else { return nil }
        let path = "https://image.tmdb.org/t/p/w300" + posterPath
        return URL(string: path)
    }

    var dateYearOnly: String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        guard let releaseDate, let date = formatter.date(from: releaseDate) else { return nil }
        formatter.dateFormat = "yyyy"
        return formatter.string(from: date)
    }
}
