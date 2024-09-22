//
//  MoviesLocalRepository.swift
//  MoviesApp
//
//  Created by Leonardo on 9/22/24.
//

import Foundation

struct MoviesLocalRepository: MoviesLocalRepositoryProtocol {
    private let container = CoreDataManager.shared.container

    func getWatchList() -> [Movie] {
        let cdMovies = container.getAll(type: CDMovie.self)
        Logger.log(.coreData, .other, msg: "Found \(cdMovies.count) movies.")
        return cdMovies.map { $0.toMovie() }
    }

    func addMovieToWatchList(movie: Movie) {
        guard container.getAll(type: CDMovie.self, filterBy: [movie.id]).isEmpty else {
            Logger.log(.coreData, .error, msg: "Movie (\(movie.id)) is already added to watch list")
            return
        }

        let _ = CDMovie(context: container.viewContext, movie: movie)
        container.saveContext()
    }

    func removeMovieFromWatchList(movie: Movie) {
        guard let cdMovie = container.getAll(type: CDMovie.self, filterBy: [movie.id]).first else { return }
        container.delete(objects: [cdMovie])
    }

    func getMovieInWatchList(movieId: String) -> Movie? {
        return container.getAll(type: CDMovie.self, filterBy: [movieId]).first?.toMovie()
    }
}
