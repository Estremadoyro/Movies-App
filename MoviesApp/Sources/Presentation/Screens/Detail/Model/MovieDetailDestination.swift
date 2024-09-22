//
//  MovieDetailDestination.swift
//  MoviesApp
//
//  Created by Leonardo on 9/22/24.
//

import SwiftUI

enum MovieDetailDestination {
    case trailerView(url: URL)
    case none

    @ViewBuilder
    func makeView() -> some View {
        switch self {
        case let .trailerView(url):
//            WebViewSwiftUI(url: url)
            TrailerView(url: url)
        case .none:
            EmptyView()
        }
    }
    
    var type: `Type`? {
        switch self {
        case .trailerView:
            return .sheet
        case .none:
            return nil
        }
    }
}

extension MovieDetailDestination {
    enum `Type` {
        case sheet
    }
}
