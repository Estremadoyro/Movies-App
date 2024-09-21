//
//  MoviesRemoteRepositoryMock.swift
//  MoviesApp
//
//  Created by Leonardo on 9/21/24.
//

import Combine
import Foundation

struct MoviesRemoteRepositoryMock: MoviesRemoteRepositoryProtocol {
    func getMovies(endpoint: MoviesEndpoint) -> AnyPublisher<MoviesDatabaseDTO, NetworkServiceError> {
        return Future { (promise) in
            let filename = getFilename(byEndpoint: endpoint)
            guard let fileTxt = FileReader.read(filename: filename, type: "txt"),
                  let model = fileTxt.toModel(type: MoviesDatabaseDTO.self) else {
                promise(.failure(.other("Error reading mock")))
                return
            }
            promise(.success(model))
        }
        .delay(for: 1, scheduler: RunLoop.main)
        .eraseToAnyPublisher()
    }

    private func getFilename(byEndpoint endpoint: MoviesEndpoint) -> String {
        switch endpoint {
        case .getPopular:
            return "movies-popular"
        }
    }
}
