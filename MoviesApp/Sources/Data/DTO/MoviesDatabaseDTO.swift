//
//  MoviesDBResponse.swift
//  MoviesApp
//
//  Created by Leonardo on 9/21/24.
//

import Foundation

struct MoviesDatabaseDTO: Decodable {
    var page: Int
    var results: [MovieDatabaseDTO]?
}
