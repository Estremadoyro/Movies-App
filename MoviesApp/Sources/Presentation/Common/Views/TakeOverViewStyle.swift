//
//  NoResultsStyle.swift
//  MoviesApp
//
//  Created by Leonardo on 9/21/24.
//

import SwiftUI

enum TakeOverViewStyle {
    case empty(EmptyType)
    case start

    var icon: Image {
        switch self {
        case let .empty(type):
            type.icon
        case .start:
            Image.noResults
        }
    }

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
        case watchList
        
        var icon: Image {
            switch self {
            case .homeFilter, .remoteSearch:
                Image.noResults
            case .watchList:
                Image.emptyBox
            }
        }

        var title: String {
            switch self {
            case .homeFilter, .remoteSearch:
                return "We Are Sorry, We Can\nNot Find The Movie :("
            case .watchList:
                return "Watch List empty"
            }
        }

        var subtitle: String {
            switch self {
            case .homeFilter:
                return "Find your movie by title"
            case .watchList:
                return "Discover movies and add them to your Watch List"
            case .remoteSearch:
                return "Find your movie by title,\ncategory, release year, etc"
            }
        }
    }
}
