//
//  MovieDatabaseDTO.swift
//  MoviesApp
//
//  Created by Leonardo on 9/21/24.
//

import Foundation

struct MovieDatabaseDTO: Decodable {
    var id: Int?
    var title: String?
    var posterPath: String?
    var voteAverage: Double?
    var releaseDate: String?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
    }
}

extension MovieDatabaseDTO {
    func toMovie() -> Movie {
        var idStr: String?
        if let id { idStr = String(id) }

        return Movie(
            id: idStr ?? UUID().uuidString,
            title: title,
            posterPath: posterPath,
            voteAverage: voteAverage,
            releaseDate: releaseDate
        )
    }
}
