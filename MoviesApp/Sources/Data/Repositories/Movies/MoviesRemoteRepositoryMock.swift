//
//  MoviesRemoteRepositoryMock.swift
//  MoviesApp
//
//  Created by Leonardo on 9/21/24.
//

import Combine

struct MoviesRemoteRepositoryMock: MoviesRemoteRepositoryProtocol {
    func getMovies(endpoint: MoviesEndpoint) -> AnyPublisher<MoviesDatabaseDTO, NetworkServiceError> {
        return Future { (promise) in
            promise(.success(MoviesDatabaseDTO(page: 1, results: [.init(id: 9999, title: "mock movie")]))) // empty for now, should read from stud file
        }
        .eraseToAnyPublisher()
    }
}
