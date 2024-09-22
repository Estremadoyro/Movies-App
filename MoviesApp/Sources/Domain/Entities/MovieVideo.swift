//
//  MovieVideo.swift
//  MoviesApp
//
//  Created by Leonardo on 9/22/24.
//

import Foundation

struct MovieVideo: Identifiable, Hashable, Codable {
    let id: String
    var youtubeKey: String?

    static var sample: MovieVideo {
        MovieVideo(id: UUID().uuidString, youtubeKey: "tlFyyzXVEMk")
    }

    var youtubeURL: URL? {
        guard let youtubeKey else { return nil }
        let path = "https://www.youtube.com/watch?v=\(youtubeKey)"
        return URL(string: path)
    }
}
