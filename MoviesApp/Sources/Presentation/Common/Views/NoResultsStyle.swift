//
//  NoResultsStyle.swift
//  MoviesApp
//
//  Created by Leonardo on 9/21/24.
//

import Foundation

enum NoResultsStyle {
    case homeFilter
    case remoteSearch
    
    var subtitle: String {
        switch self {
        case .homeFilter:
            return "Find your movie by title\nor category"
        case .remoteSearch:
            return "Find your movie by title,\ncategory, release year, etc"
        }
    }
}
