//
//  HomeSectionType.swift
//  MoviesApp
//
//  Created by Leonardo on 9/21/24.
//

import Foundation

struct HomeSectionGroup: Identifiable, Hashable {
    let id = UUID().uuidString

    var type: HomeSectionType
    var categories: [MovieCategory]
}

enum HomeSectionType {
    case principal
    case secondary
}
