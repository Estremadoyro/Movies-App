//
//  AddWatchListMovieUseCase.swift
//  MoviesApp
//
//  Created by Leonardo on 9/22/24.
//

import Foundation

struct AddMovieToWatchListUseCase {
    private let repository: MoviesLocalRepositoryProtocol

    init(repository: MoviesLocalRepositoryProtocol) {
        self.repository = repository
    }

    func execute(movie: Movie) {
        repository.addMovieToWatchList(movie: movie)
    }
}
