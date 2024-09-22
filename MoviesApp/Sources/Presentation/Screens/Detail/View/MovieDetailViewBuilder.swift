//
//  MovieDetailViewBuilder.swift
//  MoviesApp
//
//  Created by Leonardo on 9/22/24.
//

import Foundation

struct MovieDetailViewBuilder {
    static func build(movie: Movie, mock: Bool = false) -> MovieDetailView {
        @LocalStorage(\.debugMode) var debugMode: Bool?
        let useMock: Bool = mock ? mock : debugMode ?? mock

        let moviesRepository: MoviesRemoteRepositoryProtocol = useMock
            ? MoviesRemoteRepositoryMock()
            : MoviesRemoteRepository()

        var movieWithDefaultValues = movie
        movieWithDefaultValues.setDefaultValues()

        let getMovieDetailByIdUseCase = GetMovieDetailByIdUseCase(repository: moviesRepository)
        return MovieDetailView(
            viewModel: MovieDetailViewModel(
                movie: movieWithDefaultValues,
                getMovieDetailByIdUseCase: getMovieDetailByIdUseCase
            )
        )
    }
}
