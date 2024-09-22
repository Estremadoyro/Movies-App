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
                }
        }
        .overlay(viewModel.isEmpty ? TakeOverView(style: .empty(.watchList)) : nil)
        .onAppear {
            viewModel.onAppear()
        }
    }

    func makeContentView() -> some View {
        ScrollView(.vertical) {
            VStack {
                ForEach(viewModel.movies) { (movie) in
                    VStack {
                        NavigationLink(value: movie) {
                            MovieCellHorizontal(movie: movie)
                                .padding(.vertical)
                                .foregroundStyle(.foreground)
                        }
                        .addChevron()
                        Divider()
                    }
                }
            }
        }
    }
}

#Preview {
    WatchListViewBuilder.build(mock: true)
}
