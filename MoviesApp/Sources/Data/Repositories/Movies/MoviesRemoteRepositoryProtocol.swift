//
//  MoviesRemoteRepositoryProtocol.swift
//  MoviesApp
//
//  Created by Leonardo on 9/21/24.
//

import Combine

protocol MoviesRemoteRepositoryProtocol {
    func getMovies(endpoint: MoviesEndpoint) -> AnyPublisher<MoviesDatabaseDTO, NetworkServiceError>
}
