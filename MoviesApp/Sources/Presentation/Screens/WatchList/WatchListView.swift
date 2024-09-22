//
//  WatchListView.swift
//  MoviesApp
//
//  Created by Leonardo on 9/22/24.
//

import SwiftUI

struct WatchListView: View {
    @StateObject var viewModel: WatchListViewModel

    var body: some View {
        NavigationStack {
            makeContentView()
                .navigationTitle("Watch list")
                .navigationBarTitleDisplayMode(.inline)
                .navigationDestination(for: Movie.self) { (movie) in
                    MovieDetailViewBuilder.build(movie: movie)
                        .onDisappear {
                            viewModel.syncMovies()
                        }
                }
        }
        .overlay(viewModel.isEmpty ? TakeOverView(style: .empty(.watchList)) : nil)
        .animation(.default, value: viewModel.movies)
        .transition(.opacity)
        .onAppear {
            viewModel.syncMovies()
        }
    }

    func makeContentView() -> some View {
        ScrollView(.vertical) {
            ForEach(viewModel.movies) { (movie) in
                VStack {
                    NavigationLink(value: movie) {
                        MovieCellHorizontal(style: .detailed, movie: movie)
                            .padding(.vertical)
                            .foregroundStyle(.foreground)
                    }
                    .addChevron()
                    Divider()
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    WatchListViewBuilder.build(mock: true)
}
