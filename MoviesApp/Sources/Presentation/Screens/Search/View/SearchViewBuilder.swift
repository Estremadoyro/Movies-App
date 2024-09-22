//
//  SearchViewBuilder.swift
//  MoviesApp
//
//  Created by Leonardo on 9/22/24.
//

import Foundation

struct SearchViewBuilder {
    static func build(mock: Bool = false) -> SearchView {
        @LocalStorage(\.debugMode) var debugMode: Bool?
        let useMock: Bool = mock ? mock : debugMode ?? mock

        let moviesRepository: MoviesRemoteRepositoryProtocol = useMock
            ? MoviesRemoteRepositoryMock()
            : MoviesRemoteRepository()

        let searchRemoteMoviesUseCase = SearchRemoteMoviesUseCase(repository: moviesRepository)
        return SearchView(
            viewModel: SearchViewModel(searchRemoteMoviesUseCase: searchRemoteMoviesUseCase)
        )
    }
}
