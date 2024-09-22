//
//  SearchView.swift
//  MoviesApp
//
//  Created by Leonardo on 9/22/24.
//

import SwiftUI

struct SearchView: View {
    @StateObject var viewModel: SearchViewModel

    var body: some View {
        NavigationStack {
            makeContentView()
                .navigationTitle("Search")
                .navigationBarTitleDisplayMode(.inline)
                .searchable(
                    text: $viewModel.input,
                    placement: .navigationBarDrawer(displayMode: .always),
                    prompt: Text("Search movies across TheMovieDB")
                )
                .navigationDestination(for: Movie.self) { (movie) in
                    MovieDetailViewBuilder.build(movie: movie)
                }
        }
        .onFirstAppear {
            viewModel.onFirstAppear()
        }
        .overlay(
            makeTakeOverView()
                .animation(.default, value: viewModel.status)
        )
    }
}

// MARK: - Content
private extension SearchView {
    func makeContentView() -> some View {
        ScrollView(.vertical) {
            LazyVStack {
                ForEach(viewModel.movies) { (movie) in
                    VStack {
                        NavigationLink(value: movie) {
                            MovieCellHorizontal(movie: movie)
                                .addChevron()
                                .padding(.vertical)
                        }
                        .foregroundStyle(.foreground)
                        Divider()
                    }
                }
                .padding(.horizontal)
            }
        }
        .animation(.default, value: viewModel.movies.map(\.id))
        .animation(.default, value: viewModel.status)
    }
}

// MARK: - TakeOver
private extension SearchView {
    @ViewBuilder
    func makeTakeOverView() -> some View {
        switch viewModel.status {
        case .idle:
            TakeOverView(style: .start)
        case .searching:
            ReusableProgressView()
                .controlSize(.large)
                .tint(.gray)
                .padding()
                .background(.gray.opacity(0.6))
                .addCornerRadius(radius: 8)
        case .noResults:
            TakeOverView(style: .empty(.remoteSearch))
        case .found:
            EmptyView()
        }
    }
}

// MARK: - Preview
#Preview {
    SearchViewBuilder.build(mock: true)
}
