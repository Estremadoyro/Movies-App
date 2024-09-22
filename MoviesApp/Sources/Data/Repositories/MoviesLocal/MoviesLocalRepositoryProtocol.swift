//
//  MoviesLocalRepositoryProtocol.swift
//  MoviesApp
//
//  Created by Leonardo on 9/22/24.
//

import Foundation

protocol MoviesLocalRepositoryProtocol {
    func getWatchList() -> [Movie]
}
