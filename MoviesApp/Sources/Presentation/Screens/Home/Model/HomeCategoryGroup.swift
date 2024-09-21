//
//  HomeSection.swift
//  MoviesApp
//
//  Created by Leonardo on 9/21/24.
//

import Foundation

struct HomeCategoryGroup: Identifiable, Hashable {
    var id: String
    var status: HomeCategoryStatus
    var category: MovieCategory
    var movies: [HomeMovie]

    static func makePlaceholders(forCategory category: MovieCategory) -> HomeCategoryGroup {
        HomeCategoryGroup(
            id: UUID().uuidString,
            status: .idle,
            category: category,
            movies: (0 ..< category.placeholderCount).map { _ in .placeholder }
        )
    }
}
