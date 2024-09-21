//
//  GetMoviesByCategoryUseCase.swift
//  MoviesApp
//
//  Created by Leonardo on 9/21/24.
//

import Combine

struct GetMoviesByCategoryUseCase {
    private let repository: MoviesRemoteRepositoryProtocol

    init(repository: MoviesRemoteRepositoryProtocol) {
        self.repository = repository
    }

    func execute(category: MovieCategory, page: Int) -> AnyPublisher<[Movie], NetworkServiceError> {
        let endpoint: MoviesEndpoint
        switch category {
        case .popular:
            endpoint = .getPopular(page: page)
        case .nowPlaying:
            endpoint = .getPopular(page: page)
        case .upcoming:
            endpoint = .getPopular(page: page)
        case .topRated:
            endpoint = .getPopular(page: page)
        }

        return repository
            .getMovies(endpoint: endpoint)
            .compactMap(\.results)
            .map { $0.map { $0.toMovie() }}
            .eraseToAnyPublisher()
    }
}
