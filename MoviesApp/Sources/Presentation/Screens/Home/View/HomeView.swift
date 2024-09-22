//
//  HomeView.swift
//  MoviesApp
//
//  Created by Leonardo on 9/20/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel

    var body: some View {
        NavigationStack {
            makeMainView()
                .blur(radius: viewModel.isSearching ? 6 : .zero)
                .overlay(viewModel.isSearching ? makeSearchView() : nil)
                .navigationTitle("What do you want to watch?")
                .navigationBarTitleDisplayMode(.inline)
                .searchable(
                    text: $viewModel.input,
                    placement: .navigationBarDrawer(displayMode: .always),
                    prompt: Text("Search across 4 categories")
                )
                .animation(.default, value: viewModel.isSearching)
        }
    }
}

// MARK: - Content
private extension HomeView {
    func makeMainView() -> some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 40) {
                ForEach(viewModel.sections, content: makeSections)
            }
        }
    }

    func makeSearchView() -> some View {
        ZStack {
            Color.dynamicWhite
                .opacity(0.8)
                .ignoresSafeArea()
            ScrollView(.vertical) {
                LazyVStack {
                    ForEach(viewModel.visibleMovies) { (homeMovie) in
                        MovieCellSearch(movie: homeMovie.movie)
                            .padding(.vertical)
                        Divider()
                    }
                }
                .padding()
            }
        }
        .frame(width: screenSize.width)
        .overlay(viewModel.visibleMovies.isEmpty ? TakeOverView(style: .empty(.homeFilter)) : nil)
        .animation(.default, value: viewModel.visibleMovies.map(\.id))
    }
}

// MARK: - Sections
private extension HomeView {
    @ViewBuilder
    func makeSections(section: HomeSection) -> some View {
        switch section.type  {
        case .principal:
            makeSectionPrincipal(section: section)
        case .secondary:
            makeSectionSecondary(section: section)
        }
    }
}

// MARK: - Section (Principal)
private extension HomeView {
    func makeSectionPrincipal(section: HomeSection) -> some View {
        ForEach(section.movieGroups) { (categoryGroup) in
            ScrollView(.horizontal) {
                HStack {
                    ForEach(Array(categoryGroup.movies.enumerated()), id: \.element) { (i, homeMovie) in
                        switch section.type {
                        case .principal:
                            HomeMovieCellPrincipal(position: i + 1, homeMovie: homeMovie)
                        case .secondary:
                            HomeMovieCellSecondary(homeMovie: homeMovie)
                        }
                    }
                }
                .padding(.horizontal)
            }
            .scrollIndicators(.never)
            .onFirstAppear {
                viewModel.loadMovies(homeSection: section, homeCategory: categoryGroup)
            }
        }
    }
}

// MARK: - Section (Secondary)
private extension HomeView {
    @ViewBuilder
    func makeSectionSecondary(section: HomeSection) -> some View {
        VStack(spacing: 12) {
            HomeCategoriesHeaderView(
                selectedCategory: $viewModel.selectedSecondaryCategory,
                categories: section.movieGroups.map(\.category)
            )
            .padding(.horizontal)

            HomeSecondaryGridView(
                selectedCategory: $viewModel.selectedSecondaryCategory,
                categoryGroups: section.movieGroups
            ) { (homeCategory) in
                viewModel.loadMovies(homeSection: section, homeCategory: homeCategory)
            }
            .frame(height: 360)
        }
        .animation(.default, value: viewModel.selectedSecondaryCategory)
        .onChange(of: viewModel.selectedSecondaryCategory) { _ in
            HapticManager.runSelection()
        }
    }
}

// MARK: - Group (Popular)
private extension HomeView {
    func makeSectionGroupPopular() -> some View {
        Text("Section popular")
    }
}

// MARK: - Preview
#Preview {
    HomeViewBuilder.build(mock: true)
}
