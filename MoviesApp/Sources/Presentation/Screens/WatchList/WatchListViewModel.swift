//
//  WatchListViewModel.swift
//  MoviesApp
//
//  Created by Leonardo on 9/22/24.
//

import SwiftUI

final class WatchListViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var isEmpty: Bool = false

    private let getWatchListMoviesUseCase: GetWatchListMoviesUseCase

    init(getWatchListMoviesUseCase: GetWatchListMoviesUseCase) {
        self.getWatchListMoviesUseCase = getWatchListMoviesUseCase
    }

    func syncMovies() {
        self.movies = getWatchListMoviesUseCase.execute()
        withAnimation {
            isEmpty = self.movies.isEmpty
        }
    }
}
