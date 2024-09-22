//
//  CheckMovieIsInWatchList.swift
//  MoviesApp
//
//  Created by Leonardo on 9/22/24.
//

import Foundation

struct GetMovieInWatchListUseCase {
    private let repository: MoviesLocalRepositoryProtocol

    init(repository: MoviesLocalRepositoryProtocol) {
        self.repository = repository
    }

    func execute(movieId: String) -> Movie? {
        repository.getMovieInWatchList(movieId: movieId)
    }
}
