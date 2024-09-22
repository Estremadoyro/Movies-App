//
//  HomeSection.swift
//  MoviesApp
//
//  Created by Leonardo on 9/21/24.
//

import Foundation

struct HomeSection: Identifiable, Hashable {
    let id = UUID().uuidString

    var type: HomeSectionType
    var movieGroups: [HomeCategoryGroup]

    mutating func updateHomeCategoryStatus(_ homeCategory: HomeCategoryGroup, newStatus: HomeCategoryStatus) {
        movieGroups.update(element: homeCategory, update: UpdateWrapper(property: \.status, newValue: newStatus))
    }

    mutating func updateMovieCategories(_ homeCategory: HomeCategoryGroup) {
        movieGroups.update(element: homeCategory, update: UpdateWrapper(property: \.movies, newValue: homeCategory.movies))
    }

    func checkCategoryGroup(is status: HomeCategoryStatus, homeCategory: HomeCategoryGroup) -> Bool {
        movieGroups.first(where: { $0.id == homeCategory.id })?.status == status
    }
}
