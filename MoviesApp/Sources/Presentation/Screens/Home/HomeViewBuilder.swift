//
//  HomeViewBuilder.swift
//  MoviesApp
//
//  Created by Leonardo on 9/21/24.
//

import Foundation

struct HomeViewBuilder {
    static func build(mock: Bool = false) -> HomeView {
        let moviesRepository: MoviesRemoteRepositoryProtocol = mock
            ? MoviesRemoteRepositoryMock()
            : MoviesRemoteRepository()
        let getMoviesByCategoryUseCase = GetMoviesByCategoryUseCase(repository: moviesRepository)
        return HomeView(viewModel: HomeViewModel(getMoviesByCategoryUseCase: getMoviesByCategoryUseCase))
    }
}
