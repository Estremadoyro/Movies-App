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

    func execute(category: MovieCategory, page: Int) -> AnyPublisher<[HomeMovie], NetworkServiceError> {
        let endpoint: MoviesEndpoint
        switch category {
        case .popular:
            endpoint = .getPopular(page: page)
        case .nowPlaying:
            endpoint = .getNowPlaying(page: page)
        case .upcoming:
            endpoint = .getUpcoming(page: page)
        case .topRated:
            endpoint = .getTopRated(page: page)
        }

        return repository
            .getMovies(endpoint: endpoint)
            .compactMap(\.results)
            .map { (results) in
                if category == .popular {
                    return results.map { HomeMovie(movie: $0.toMovie()) }
                } else {
                    return Array(results.prefix(6)).map { HomeMovie(movie: $0.toMovie()) }
                }
            }
            .eraseToAnyPublisher()
    }
}
