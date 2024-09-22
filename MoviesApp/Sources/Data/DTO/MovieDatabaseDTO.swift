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
    var backdropPath: String?
    var voteAverage: Double?
    var releaseDate: String?
    var runtime: Int?
    var overview: String?
    var genres: [MovieDatabaseGenreDTO]?
    var videos: MoviesDatabaseDTO<MovieDatabaseVideoDTO>?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
        case overview
        case runtime
        case genres
        case videos
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
            backdropPath: backdropPath,
            voteAverage: voteAverage,
            releaseDate: releaseDate,
            overview: overview,
            runtime: runtime,
            genres: genres?.map { $0.toMovieGenre() },
            videos: videos?.results?.map { $0.toVideo() }
        )
    }
}
