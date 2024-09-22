//
//  NoResultsStyle.swift
//  MoviesApp
//
//  Created by Leonardo on 9/21/24.
//

import Foundation

enum TakeOverViewStyle {
    case empty(EmptyType)
    case start

    var title: String {
        switch self {
        case let .empty(type):
            return type.title
        case .start:
            return "Search through over 10,000 movies from TheMovieDB!"
        }
    }

    var subtitle: String {
        switch self {
        case let .empty(type):
            return type.subtitle
        case .start:
            return "Search by original, translated\nand alternative titles"
        }
    }
}

extension TakeOverViewStyle {
    enum EmptyType {
        case homeFilter
        case remoteSearch

        var title: String {
            "We Are Sorry, We Can\nNot Find The Movie :("
        }

        var subtitle: String {
            switch self {
            case .homeFilter:
                return "Find your movie by title or category"
            case .remoteSearch:
                return "Find your movie by title,\ncategory, release year, etc"
            }
        }
    }
}
