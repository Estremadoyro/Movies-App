//
//  MoviesLocalRepositoryProtocol.swift
//  MoviesApp
//
//  Created by Leonardo on 9/22/24.
//

import Foundation

protocol MoviesLocalRepositoryProtocol {
    func getWatchList() -> [Movie]
    func addMovieToWatchList(movie: Movie)
    func removeMovieFromWatchList(movie: Movie)
    func getMovieInWatchList(movieId: String) -> Movie?
}
