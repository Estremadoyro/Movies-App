//
//  MoviesRemoteRepositoryMock.swift
//  MoviesApp
//
//  Created by Leonardo on 9/21/24.
//

import Combine
import Foundation

struct MoviesRemoteRepositoryMock: MoviesRemoteRepositoryProtocol {
    func getMovies(endpoint: MoviesEndpoint) -> AnyPublisher<MoviesDatabaseDTO<MovieDatabaseDTO>, NetworkServiceError> {
        return Future { (promise) in
            let filename = getFilename(byEndpoint: endpoint)
            guard let fileTxt = FileReader.read(filename: filename, type: "txt"),
                  let model = fileTxt.toModel(type: MoviesDatabaseDTO<MovieDatabaseDTO>.self) else {
                promise(.failure(.other("Error reading mock")))
                return
            }
            promise(.success(model))
        }
        .delay(for: .seconds(getDelay(byEndpoint: endpoint)), scheduler: RunLoop.main)
        .eraseToAnyPublisher()
    }

    func getMovieDetail(byMovieId movieId: Int) -> AnyPublisher<MovieDatabaseDTO, NetworkServiceError> {
        return Future { (promise) in
            guard let fileTxt = FileReader.read(filename: "movie-detail", type: "txt"),
                  let model = fileTxt.toModel(type: MovieDatabaseDTO.self) else {
                promise(.failure(.other("Error reading mock")))
                return
            }
            promise(.success(model))
        }
        .delay(for: .seconds(0.5), scheduler: RunLoop.main)
        .eraseToAnyPublisher()
    }
}

private extension MoviesRemoteRepositoryMock {
    func getFilename(byEndpoint endpoint: MoviesEndpoint) -> String {
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
        case .getDetail:
            return "movie-detail"
        }
    }

    func getDelay(byEndpoint endpoint: MoviesEndpoint) -> Double {
        switch endpoint {
        case .search:
            return 2
        default:
            return 0.5
        }
    }
}
