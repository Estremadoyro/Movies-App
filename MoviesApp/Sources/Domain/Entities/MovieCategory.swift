//
//  MovieCategory.swift
//  MoviesApp
//
//  Created by Leonardo on 9/21/24.
//

import Foundation

enum MovieCategory: Int, Identifiable, Hashable, Equatable {
    case popular = 0
    case nowPlaying
    case upcoming
    case topRated

    var id: Int { self.rawValue }

    var title: String {
        switch self {
        case .popular:
            return "Popular"
        case .nowPlaying:
            return "Now playing"
        case .upcoming:
            return "Upcoming"
        case .topRated:
            return "Top rated"
        }
    }

    var placeholderCount: Int {
        switch self {
        case .popular:
            return 4
        case .nowPlaying, .upcoming, .topRated:
            return 6
        }
    }
}
