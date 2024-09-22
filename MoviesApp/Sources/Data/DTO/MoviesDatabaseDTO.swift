//
//  MoviesDBResponse.swift
//  MoviesApp
//
//  Created by Leonardo on 9/21/24.
//

import Foundation

struct MoviesDatabaseDTO<T: Decodable>: Decodable {
    var page: Int?
    var results: [T]?
}
