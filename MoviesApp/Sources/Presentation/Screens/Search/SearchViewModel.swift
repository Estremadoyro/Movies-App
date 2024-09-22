//
//  SearchViewModel.swift
//  MoviesApp
//
//  Created by Leonardo on 9/22/24.
//

import Combine
import SwiftUI

final class SearchViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var input = String.empty {
        didSet { handleDidCancelSearch() }
    }

    @Published var status: SearchStatus = .idle

    private var cache: [String: Movie] = [:]
    private let searchRemoteMoviesUseCase: SearchRemoteMoviesUseCase
    private var cancellables = Set<AnyCancellable>()

    init(searchRemoteMoviesUseCase: SearchRemoteMoviesUseCase) {
        self.searchRemoteMoviesUseCase = searchRemoteMoviesUseCase
    }

    func onFirstAppear() {
        listenToUserInput()
    }
}

private extension SearchViewModel {
    func listenToUserInput() {
        $input
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .filter { $0.count > 2 }
            .removeDuplicates()
            .sink { [weak self] (_) in
                guard let self, self.status != .searching else { return }
                self.status = .searching
                self.searchMovies()
            }
            .store(in: &cancellables)
        
        $input
            .removeDuplicates()
            .sink { [weak self] (_) in
                self?.showCacheFilteredMovies()
            }
            .store(in: &cancellables)
    }

    func searchMovies() {
        searchRemoteMoviesUseCase.execute(query: input)
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: { [weak self] (completion) in
                    guard case .failure = completion else { return }
                    self?.status = .noResults
                },
                receiveValue: { [weak self] (movies) in
                    self?.handleDidReceiveMovies(movies)
                    self?.updateCache(movies: movies)
                }
            )
            .store(in: &cancellables)
    }

    func showCacheFilteredMovies() {
        self.movies = findMoviesInCache()
    }

    func handleDidReceiveMovies(_ movies: [Movie]) {
        self.movies = movies
        status = movies.isEmpty ? .noResults : .found
    }

    func updateCache(movies: [Movie]) {
        movies.forEach { [weak self] (movie) in
            if self?.cache[movie.id] == nil {
                self?.cache[movie.id] = movie
            }
        }
    }

    func findMoviesInCache() -> [Movie] {
        if input.isEmpty {
            return cache.values.map { $0 }
        } else {
            return cache.values.map { $0 }.filter { [weak self] (movie) in
                guard let self, let title = movie.title else { return false }
                return title.localizedCaseInsensitiveContains(self.input)
            }
        }
    }

    func handleDidCancelSearch() {
        guard input.isEmpty, status == .noResults else { return }
        showCacheFilteredMovies()
        status = movies.isEmpty ? .noResults : .found
    }
}
