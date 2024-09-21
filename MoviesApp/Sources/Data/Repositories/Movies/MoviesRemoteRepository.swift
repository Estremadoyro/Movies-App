//
//  MoviesRemoteRepositoryMock.swift
//  MoviesApp
//
//  Created by Leonardo on 9/21/24.
//

import Combine

struct MoviesRemoteRepository: MoviesRemoteRepositoryProtocol {
    func getMovies(endpoint: MoviesEndpoint) -> AnyPublisher<MoviesDatabaseDTO, NetworkServiceError> {
        NetworkManager.shared.request(
            type: MoviesDatabaseDTO.self,
            endpoint: endpoint
        )
    }
}
