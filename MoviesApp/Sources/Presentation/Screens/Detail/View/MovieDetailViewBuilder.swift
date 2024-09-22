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

        let moviesRemoteRepository: MoviesRemoteRepositoryProtocol = useMock
            ? MoviesRemoteRepositoryMock()
            : MoviesRemoteRepository()

        let moviesLocalRepository: MoviesLocalRepositoryProtocol = useMock
            ? MoviesLocalRepositoryMock()
            : MoviesLocalRepository()

        let getMovieDetailByIdUseCase = GetMovieDetailByIdUseCase(repository: moviesRemoteRepository)
        let removeMovieFromWatchListUseCase = RemoveMovieFromWatchListUseCase(repository: moviesLocalRepository)
        let addMovieToWatchListUseCase = AddMovieToWatchListUseCase(repository: moviesLocalRepository)
        let getMovieInWatchListUseCase = GetMovieInWatchListUseCase(repository: moviesLocalRepository)

        return MovieDetailView(
            viewModel: MovieDetailViewModel(
                movie: movie,
                getMovieDetailByIdUseCase: getMovieDetailByIdUseCase,
                removeMovieFromWatchListUseCase: removeMovieFromWatchListUseCase,
                addMovieToWatchListUseCase: addMovieToWatchListUseCase,
                getMovieInWatchListUseCase: getMovieInWatchListUseCase
            )
        )
    }
}
