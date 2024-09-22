//
//  GetMovieDetailById.swift
//  MoviesApp
//
//  Created by Leonardo on 9/22/24.
//

import Combine

struct GetMovieDetailByIdUseCase {
    private let repository: MoviesRemoteRepositoryProtocol
    
    init(repository: MoviesRemoteRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(movieId: Int) -> AnyPublisher<Movie, NetworkServiceError> {
        repository.getMovieDetail(byMovieId: movieId)
            .map { $0.toMovie() }
            .eraseToAnyPublisher()
    }
}
