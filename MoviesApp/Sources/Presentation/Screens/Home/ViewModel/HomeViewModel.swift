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
    @Published var selectedSecondaryCategory: MovieCategory = .nowPlaying
    @Published var input = String.empty

    private let getMoviesByCategoryUseCase: GetMoviesByCategoryUseCase
    private var cancellables = Set<AnyCancellable>()

    init(getMoviesByCategoryUseCase: GetMoviesByCategoryUseCase) {
        self.getMoviesByCategoryUseCase = getMoviesByCategoryUseCase
        makeSectionsStructure()
    }

    deinit {
        cancellables.removeAll()
    }

    var isSearching: Bool { !input.isEmpty }

    var visibleMovies: [HomeMovie] {
        filterMoviesByInput()
    }

    func loadMovies(homeSection: HomeSection, homeCategory: HomeCategoryGroup) {
        requestMovies(homeSection: homeSection, homeCategory: homeCategory)
    }

    func checkSecondaryCategorySelected(_ secondaryCategory: MovieCategory) -> Bool {
        return selectedSecondaryCategory.id == secondaryCategory.id
    }

    func getSelectedCategoryGroups(forSection section: HomeSection) -> [HomeCategoryGroup] {
        return section.movieGroups.filter({ $0.category.id == selectedSecondaryCategory.id })
    }
}

private extension HomeViewModel {
    func makeSectionsStructure() {
        guard sections.isEmpty else { return }
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
        guard homeSection.checkCategoryGroup(is: .idle, homeCategory: homeCategory) else { return }
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
        let homeCategoryGroup = HomeCategoryGroup(status: .completed, category: homeCategory.category, movies: homeMovies)
        guard let sectionIndex = sections.firstIndex(where: { $0.id == homeSection.id }) else { return }
        sections[safe: sectionIndex]?.updateMovieCategories(homeCategoryGroup)
    }

    func updateCategoryStatus(homeSection: HomeSection, homeCategory: HomeCategoryGroup, newStatus: HomeCategoryStatus) {
        guard let sectionIndex = sections.firstIndex(where: { $0.id == homeSection.id }) else { return }
        sections[safe: sectionIndex]?.updateHomeCategoryStatus(homeCategory, newStatus: newStatus)
    }

    func filterMoviesByInput() -> [HomeMovie] {
        sections.flatMap { $0.movieGroups.flatMap(\.movies) }
            .unique(identifier: { $0.movie.id }) // prevent duplicated movies
            .filter { !$0.isPlaceholder }
            .filter {
                if let title = $0.movie.title {
                    return title.localizedCaseInsensitiveContains(input)
                } else {
                    return true
                }
            }
    }
}
