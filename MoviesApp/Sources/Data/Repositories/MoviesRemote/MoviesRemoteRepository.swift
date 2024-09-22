//
//  MoviesRemoteRepositoryMock.swift
//  MoviesApp
//
//  Created by Leonardo on 9/21/24.
//

import Combine

struct MoviesRemoteRepository: MoviesRemoteRepositoryProtocol {
    func getMovies(endpoint: MoviesEndpoint) -> AnyPublisher<MoviesDatabaseDTO<MovieDatabaseDTO>, NetworkServiceError> {
        NetworkManager.shared.request(
            type: MoviesDatabaseDTO.self,
            endpoint: endpoint
        )
    }

    func getMovieDetail(byMovieId movieId: Int) -> AnyPublisher<MovieDatabaseDTO, NetworkServiceError> {
        NetworkManager.shared.request(
            type: MovieDatabaseDTO.self,
            endpoint: MoviesEndpoint.getDetail(movieId: movieId)
        )
    }
}
