//
//  MovieDatabaseDTO.swift
//  MoviesApp
//
//  Created by Leonardo on 9/21/24.
//

import Foundation

struct MovieDatabaseDTO: Decodable {
    var id: Int?
    var title: String?
}

extension MovieDatabaseDTO {
    func toMovie() -> Movie {
        var idStr: String?
        if let id { idStr = String(id) }

        return Movie(
            id: idStr ?? UUID().uuidString,
            title: title
        )
    }
}
