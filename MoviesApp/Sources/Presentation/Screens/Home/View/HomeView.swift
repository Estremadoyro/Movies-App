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
            makeContentView()
                .navigationTitle("What do you want to watch?")
                .navigationBarTitleDisplayMode(.inline)
                .searchable(
                    text: .constant(.empty),
                    placement: .navigationBarDrawer(displayMode: .always)
                )
        }
    }
}

// MARK: - Content
private extension HomeView {
    func makeContentView() -> some View {
        ScrollView(.vertical) {
            LazyVStack {
                ForEach(viewModel.sections, content: makeSections)
            }
        }
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
    func makeSectionSecondary(section: HomeSection) -> some View {
        Text("seciton secondary")
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
