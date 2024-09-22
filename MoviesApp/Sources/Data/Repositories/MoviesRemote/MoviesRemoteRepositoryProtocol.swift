//
//  MoviesRemoteRepositoryProtocol.swift
//  MoviesApp
//
//  Created by Leonardo on 9/21/24.
//

import Combine

protocol MoviesRemoteRepositoryProtocol {
    func getMovies(endpoint: MoviesEndpoint) -> AnyPublisher<MoviesDatabaseDTO<MovieDatabaseDTO>, NetworkServiceError>
    func getMovieDetail(byMovieId movieId: Int) -> AnyPublisher<MovieDatabaseDTO, NetworkServiceError>
}
