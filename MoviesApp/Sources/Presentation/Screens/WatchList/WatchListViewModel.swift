//
//  WatchListViewModel.swift
//  MoviesApp
//
//  Created by Leonardo on 9/22/24.
//

import SwiftUI

final class WatchListViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    
    private let getWatchListMoviesUseCase: GetWatchListMoviesUseCase
    
    init(getWatchListMoviesUseCase: GetWatchListMoviesUseCase) {
        self.getWatchListMoviesUseCase = getWatchListMoviesUseCase
    }
    
    var isEmpty: Bool { movies.isEmpty }
    
    func onAppear() {
        movies = getWatchListMoviesUseCase.execute()
    }
}
