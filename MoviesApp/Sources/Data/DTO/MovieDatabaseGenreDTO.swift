//
//  MovieDatabaseGenreDTO.swift
//  MoviesApp
//
//  Created by Leonardo on 9/22/24.
//

import Foundation

struct MovieDatabaseGenreDTO: Decodable {
    var id: String
    var name: String

    enum CodingKeys: CodingKey {
        case id
        case name
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let id = try container.decodeIfPresent(Int.self, forKey: .id) {
            self.id = String(id)
        } else {
            self.id = UUID().uuidString
        }
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? .empty
    }
}

extension MovieDatabaseGenreDTO {
    func toMovieGenre() -> MovieGenre {
        MovieGenre(id: id, name: name)
    }
}
