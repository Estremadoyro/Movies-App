//
//  HomeViewModel.swift
//  MoviesApp
//
//  Created by Leonardo on 9/20/24.
//

import Combine
import SwiftUI

final class HomeViewModel: ObservableObject {
    @Published var sections: [HomeSection] = []

    private let getMoviesByCategoryUseCase: GetMoviesByCategoryUseCase
    private var cancellables = Set<AnyCancellable>()

    init(getMoviesByCategoryUseCase: GetMoviesByCategoryUseCase) {
        self.getMoviesByCategoryUseCase = getMoviesByCategoryUseCase
        makeSectionsStructure()
    }

    deinit {
        cancellables.removeAll()
    }
    
    func loadMovies(homeSection: HomeSection, homeCategory: HomeCategoryGroup) {
        requestMovies(homeSection: homeSection, homeCategory: homeCategory)
    }
}

private extension HomeViewModel {
    func makeSectionsStructure() {
        guard sections.isEmpty else { return }
        /// The **UI is driven by the structure of the sectionGroups**, order matters.
        let sectionGroups: [HomeSectionGroup] = [
            HomeSectionGroup(type: .principal, categories: [.popular]),
            HomeSectionGroup(type: .secondary, categories: [.nowPlaying, .upcoming, .topRated])
        ]

        let homeSections: [HomeSection] = sectionGroups.map { (section) in
            HomeSection(type: section.type, movieGroups: section.categories.map(HomeCategoryGroup.makePlaceholders))
        }

        self.sections = homeSections
    }

    func requestMovies(homeSection: HomeSection, homeCategory: HomeCategoryGroup)  {
        updateCategoryStatus(homeSection: homeSection, homeCategory: homeCategory, newStatus: .loading)
        getMoviesByCategoryUseCase.execute(category: homeCategory.category, page: 1)
            .receive(on: RunLoop.main)
            .sink { (completion) in
                guard case .failure = completion else { return }
                // handle errors
            } receiveValue: { [weak self, homeSection, homeCategory] (homeMovies) in
                self?.handleDidReceiveMovies(homeSection: homeSection, homeCategory: homeCategory, homeMovies: homeMovies)
            }
            .store(in: &cancellables)
    }

    func handleDidReceiveMovies(homeSection: HomeSection, homeCategory: HomeCategoryGroup, homeMovies: [HomeMovie]) {
        let homeCategoryGroup = HomeCategoryGroup(id: homeCategory.id, status: .completed, category: homeCategory.category, movies: homeMovies)
        guard let sectionIndex = sections.firstIndex(where: { $0.id == homeSection.id }) else { return }
        withAnimation {
            sections[safe: sectionIndex]?.updateMovieCategories(homeCategoryGroup)
        }
    }

    func updateCategoryStatus(homeSection: HomeSection, homeCategory: HomeCategoryGroup, newStatus: HomeCategoryStatus) {
        guard let sectionIndex = sections.firstIndex(where: { $0.id == homeSection.id }) else { return }
        sections[safe: sectionIndex]?.updateHomeCategoryStatus(homeCategory, newStatus: newStatus)
    }
}
