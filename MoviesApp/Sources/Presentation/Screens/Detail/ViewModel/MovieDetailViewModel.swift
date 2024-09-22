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
    private let removeMovieFromWatchListUseCase: RemoveMovieFromWatchListUseCase
    private let addMovieToWatchListUseCase: AddMovieToWatchListUseCase
    private let getMovieInWatchListUseCase: GetMovieInWatchListUseCase
    private var cancellables = Set<AnyCancellable>()

    init(
        movie: Movie,
        getMovieDetailByIdUseCase: GetMovieDetailByIdUseCase,
        removeMovieFromWatchListUseCase: RemoveMovieFromWatchListUseCase,
        addMovieToWatchListUseCase: AddMovieToWatchListUseCase,
        getMovieInWatchListUseCase: GetMovieInWatchListUseCase
    ) {
        self._movie = Published(initialValue: movie)
        self.getMovieDetailByIdUseCase = getMovieDetailByIdUseCase
        self.removeMovieFromWatchListUseCase = removeMovieFromWatchListUseCase
        self.addMovieToWatchListUseCase = addMovieToWatchListUseCase
        self.getMovieInWatchListUseCase = getMovieInWatchListUseCase
        loadDetailMovie()
    }

    func onAppear() {
        syncWatchListStatus()
    }

    func changeWatchListStatus() {
        isInWatchList.toggle()

        if isInWatchList {
            addMovieToWatchListUseCase.execute(movie: movie)
            HapticManager.runSuccess()
        } else {
            removeMovieFromWatchListUseCase.execute(movie: movie)
        }
    }

    func openTrailerView(url: URL?) {
        guard let url else { return }
        destination = .trailerView(url: url)
        HapticManager.runLight()
    }
}

private extension MovieDetailViewModel {
    func syncWatchListStatus() {
        isInWatchList = getMovieInWatchListUseCase.execute(movieId: movie.id).isNotNil
    }

    func loadDetailMovie() {
        guard let movieId = Int(movie.id) else { return }

        if let movieInWatchList = getMovieInWatchListUseCase.execute(movieId: "\(movieId)") {
            isInWatchList = true
            handleDidReceiveDetailMovie(movieInWatchList)
        } else {
            movie.setDefaultValuesIfNeeded()
            getMovieDetailByIdUseCase.execute(movieId: movieId)
                .receive(on: RunLoop.main)
                .sink { (completion) in
                    guard case .failure = completion else { return }
                    // handle error
                } receiveValue: { [weak self] (detailMovie) in
                    self?.handleDidReceiveDetailMovie(detailMovie)
                }
                .store(in: &cancellables)
        }
    }

    func handleDidReceiveDetailMovie(_ movie: Movie) {
        withAnimation {
            self.movie.updateDetailValues(detailMovie: movie)
            isLoading = false
        }
    }
}
