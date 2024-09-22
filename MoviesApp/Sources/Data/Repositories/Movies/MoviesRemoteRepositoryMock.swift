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
        .delay(for: .seconds(getDelay(byEndpoint: endpoint)), scheduler: RunLoop.main)
        .eraseToAnyPublisher()
    }

    private func getFilename(byEndpoint endpoint: MoviesEndpoint) -> String {
        switch endpoint {
        case .getPopular:
            return "movies-popular"
        case .getNowPlaying:
            return "movies-now-playing"
        case .getUpcoming:
            return "movies-upcoming"
        case .getTopRated:
            return "movies-top-rated"
        case .search:
            return "movies-search"
        }
    }

    private func getDelay(byEndpoint endpoint: MoviesEndpoint) -> Double {
        switch endpoint {
        case .search:
            return 2
        default:
            return 0.5
        }
    }
}
