//
//  MovieDetailViewModel.swift
//  MoviesApp
//
//  Created by Leonardo on 9/22/24.
//

import Combine
import SwiftUI

final class MovieDetailViewModel: ObservableObject {
    @Published var movie: Movie
    @Published var isInWatchList: Bool = false
    @Published var isLoading: Bool = true
    @Published var showSheet: Bool = false
    
    private(set) var destination: MovieDetailDestination = .none {
        didSet {
            guard let type = destination.type else { return }
            showSheet = type == .sheet
        }
    }

    private let getMovieDetailByIdUseCase: GetMovieDetailByIdUseCase
    private var cancellables = Set<AnyCancellable>()

    init(movie: Movie, getMovieDetailByIdUseCase: GetMovieDetailByIdUseCase) {
        self._movie = Published(initialValue: movie)
        self.getMovieDetailByIdUseCase = getMovieDetailByIdUseCase
    }

    func onFirstAppear() {
        loadDetailMovie()
    }

    func didChangeWatchListStatus() {
        // add to watchlist
        isInWatchList.toggle()
        
        if isInWatchList {
            HapticManager.runSuccess()
        }
    }
    
    func openTrailerView(url: URL?) {
        guard let url else { return }
        destination = .trailerView(url: url)
        HapticManager.runLight()
    }
}

private extension MovieDetailViewModel {
    func loadDetailMovie() {
        guard let movieId = Int(movie.id) else { return }
        getMovieDetailByIdUseCase.execute(movieId: movieId)
            .receive(on: RunLoop.main)
            .sink { [weak self] (completion) in
                guard case .failure = completion else { return }
                self?.movie.removeDetailValues()
                // handle error
            } receiveValue: { [weak self] (detailMovie) in
                self?.handleDidReceiveDetailMovie(detailMovie)
            }
            .store(in: &cancellables)
    }

    func handleDidReceiveDetailMovie(_ detailMovie: Movie) {
        withAnimation {
            movie.updateDetailValues(detailMovie: detailMovie)
            isLoading = false
        }
    }
}
