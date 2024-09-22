//
//  SearchRemoteMovieUseCase.swift
//  MoviesApp
//
//  Created by Leonardo on 9/22/24.
//

import Combine
import Foundation

struct SearchRemoteMoviesUseCase {
    private let repository: MoviesRemoteRepositoryProtocol

    init(repository: MoviesRemoteRepositoryProtocol) {
        self.repository = repository
    }

    func execute(query: String) -> AnyPublisher<[Movie], NetworkServiceError> {
        repository.getMovies(endpoint: .search(query: query))
            .compactMap(\.results)
            .map { $0.map { $0.toMovie() }}
            .eraseToAnyPublisher()
    }
}
