//
//  MovieDatabaseVideoDTO.swift
//  MoviesApp
//
//  Created by Leonardo on 9/22/24.
//

import Foundation

struct MovieDatabaseVideoDTO: Decodable {
    var id: String
    var key: String?

    enum CodingKeys: CodingKey {
        case id
        case key
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? UUID().uuidString
        self.key = try container.decodeIfPresent(String.self, forKey: .key)
    }
}

extension MovieDatabaseVideoDTO {
    func toVideo() -> MovieVideo {
        MovieVideo(id: id, youtubeKey: key)
    }
}
