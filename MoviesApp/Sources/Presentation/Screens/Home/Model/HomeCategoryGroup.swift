//
//  HomeSection.swift
//  MoviesApp
//
//  Created by Leonardo on 9/21/24.
//

import Foundation

struct HomeCategoryGroup: Identifiable, Hashable {
    var id: String { category.id }
    var status: HomeCategoryStatus
    var category: MovieCategory
    var movies: [HomeMovie]

    static func makePlaceholders(forCategory category: MovieCategory) -> HomeCategoryGroup {
        HomeCategoryGroup(
            status: .idle,
            category: category,
            movies: (0 ..< category.placeholderCount).map { _ in .placeholder }
        )
    }
    
    static func sample(forCategory category: MovieCategory) -> HomeCategoryGroup {
        HomeCategoryGroup(
            status: .completed,
            category: category,
            movies: [.sample, .sample, .sample, .sample, .sample, .sample]
        )
    }
}
