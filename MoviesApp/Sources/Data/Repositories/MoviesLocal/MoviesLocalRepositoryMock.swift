//
//  MoviesLocalRepositoryMock.swift
//  MoviesApp
//
//  Created by Leonardo on 9/22/24.
//

import Foundation

struct MoviesLocalRepositoryMock: MoviesLocalRepositoryProtocol {
    func getWatchList() -> [Movie] {
        return [.sample, .sample]
    }
}
