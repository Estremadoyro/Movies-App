//
//  MovieCategory.swift
//  MoviesApp
//
//  Created by Leonardo on 9/21/24.
//

import Foundation

enum MovieCategory {
    case popular
    case nowPlaying
    case upcoming
    case topRated

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
}
