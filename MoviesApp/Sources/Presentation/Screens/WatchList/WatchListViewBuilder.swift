//
//  WatchListViewBuilder.swift
//  MoviesApp
//
//  Created by Leonardo on 9/22/24.
//

import Foundation

struct WatchListViewBuilder {
    static func build(mock: Bool = false) -> WatchListView {
        @LocalStorage(\.debugMode) var debugMode: Bool?
        let useMock: Bool = mock ? mock : debugMode ?? mock

        let moviesRepository: MoviesLocalRepositoryProtocol = useMock
            ? MoviesLocalRepositoryMock()
            : MoviesLocalRepository()

        let getWatchListMoviesUseCase = GetWatchListMoviesUseCase(repository: moviesRepository)
        return WatchListView(
            viewModel: WatchListViewModel(getWatchListMoviesUseCase: getWatchListMoviesUseCase)
        )
    }
}
