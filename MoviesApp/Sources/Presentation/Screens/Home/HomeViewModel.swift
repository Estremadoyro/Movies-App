//
//  HomeViewModel.swift
//  MoviesApp
//
//  Created by Leonardo on 9/20/24.
//

import Combine
import SwiftUI

final class HomeViewModel: ObservableObject {
    @Published var movies: [Movie]?

    private let getMoviesByCategoryUseCase: GetMoviesByCategoryUseCase
    private var cancellables = Set<AnyCancellable>()

    init(getMoviesByCategoryUseCase: GetMoviesByCategoryUseCase) {
        self.getMoviesByCategoryUseCase = getMoviesByCategoryUseCase
    }

    deinit {
        cancellables.removeAll()
    }

    func onFirstAppear() {
        guard movies.isNil else { return }
        getAllMoviesCategories()
    }
}

private extension HomeViewModel {
    func getAllMoviesCategories() {
        let category: MovieCategory = .popular
        getMoviesByCategoryUseCase.execute(category: .popular, page: 1)
            .receive(on: RunLoop.main)
            .sink { (completion) in
                guard case .failure = completion else { return }
            } receiveValue: { [weak self, category] (movies) in
                self?.handleDidReceiveMovies(movies, forCategory: category)
            }
            .store(in: &cancellables)
    }

    func handleDidReceiveMovies(_ movies: [Movie], forCategory category: MovieCategory) {
        withAnimation {
            self.movies = movies
        }
    }
}
