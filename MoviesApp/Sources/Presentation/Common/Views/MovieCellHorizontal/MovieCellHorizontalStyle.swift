//
//  MovieCellHorizontalStyle.swift
//  MoviesApp
//
//  Created by Leonardo on 9/22/24.
//

import SwiftUI

enum MovieCellHorizontalStyle {
    case detailed
    case simple
    
    var titleLineLimit: Int {
        switch self {
        case .detailed:
            return 1
        case .simple:
            return 2
        }
    }
    
    var titleFont: Font {
        switch self {
        case .detailed:
            return .callout
        case .simple:
            return .title3
        }
    }
    
    var detailsFont: Font {
        switch self {
        case .detailed:
            return .caption
        case .simple:
            return .body
        }
    }
    
    var components: [MovieCellHorizontalComponent] {
        switch self {
        case .detailed:
            return MovieCellHorizontalComponent.allCases
        case .simple:
            return [.title, .score, .year]
        }
    }
}
