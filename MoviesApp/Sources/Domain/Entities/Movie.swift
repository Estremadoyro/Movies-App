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
    var backdropPath: String?
    var voteAverage: Double?
    var releaseDate: String?
    var overview: String?
    var runtime: Int?
    var genres: [MovieGenre]?
    var videos: [MovieVideo]?

    init(id: String, title: String? = nil, posterPath: String? = nil, backdropPath: String? = nil, voteAverage: Double? = nil, releaseDate: String? = nil, overview: String? = nil, runtime: Int? = nil, genres: [MovieGenre]? = nil, videos: [MovieVideo]? = nil) {
        self.id = id
        self.title = title
        self.posterPath = posterPath
        self.backdropPath = backdropPath
        self.voteAverage = voteAverage
        self.releaseDate = releaseDate
        self.overview = overview
        self.runtime = runtime
        self.genres = genres
        self.videos = videos
    }

    static var sample: Movie {
        Movie(
            id: "32942",
            title: "Spiderman long title spiderman owo",
            posterPath: "/8cdWjvZQUExUUTzyp4t6EDMubfO.jpg",
            backdropPath: "/yDHYTfA3R0jFYba16jBB1ef8oIt.jpg",
            voteAverage: 7.5,
            releaseDate: "2020-03-22"
        )
    }

    static var sampleDetail: Movie {
        Movie(
            id: UUID().uuidString,
            title: "Spiderman long title spiderman owo",
            posterPath: "/8cdWjvZQUExUUTzyp4t6EDMubfO.jpg",
            voteAverage: 7.5,
            releaseDate: "2020-03-22",
            overview: "Looong overview peter parker spiderman 1 2 3 long aaa",
            runtime: 120,
            genres: [.sample, .sample, .sample],
            videos: [.sample]
        )
    }

    var posterURL: URL? {
        guard let posterPath else { return nil }
        let path = "https://image.tmdb.org/t/p/w300" + posterPath
        return URL(string: path)
    }

    var backdropURL: URL? {
        guard let backdropPath else { return nil }
        let path = "https://image.tmdb.org/t/p/w780" + backdropPath
        return URL(string: path)
    }

    var dateYearOnly: String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        guard let releaseDate, let date = formatter.date(from: releaseDate) else { return nil }
        formatter.dateFormat = "yyyy"
        return formatter.string(from: date)
    }

    var mainGenre: MovieGenre? {
        genres?.first
    }

    var scoreParsed: String? {
        guard let voteAverage else { return nil }
        return String(format: "%0.1f", voteAverage)
    }

    var youtubeURL: URL? {
        videos?.first?.youtubeURL
    }

    mutating func setDefaultValuesIfNeeded() {
        if overview.isNil {
            overview = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        }
        
        if runtime.isNil {
            runtime = 200
        }
        
        if genres.isNil {
            genres = [.sample]
        }
    }

    mutating func updateDetailValues(detailMovie: Movie) {
        self.overview = detailMovie.overview
        self.runtime = detailMovie.runtime
        self.genres = detailMovie.genres
        self.videos = detailMovie.videos
    }

    mutating func removeDetailValues() {
        self.overview = nil
        self.runtime = nil
        self.genres = nil
        self.videos = nil
    }
}
