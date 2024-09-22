//
//  HomeSecondaryGridView.swift
//  MoviesApp
//
//  Created by Leonardo on 9/21/24.
//

import SwiftUI

struct HomeSecondaryGridView: View {
    @Binding var selectedCategory: MovieCategory
    var categoryGroups: [HomeCategoryGroup]
    var didFirstAppear: (HomeCategoryGroup) -> Void

    var body: some View {
        let interRowSpacing: Double = 20
        let columns = Array(repeating: GridItem(.flexible()), count: 3)

        TabView(selection: $selectedCategory) {
            ForEach(categoryGroups) { (movieGroup) in
                LazyVGrid(columns: columns, spacing: interRowSpacing) {
                    ForEach(movieGroup.movies) { (homeMovie) in
                        NavigationLink(value: homeMovie) {
                            HomeMovieCellSecondary(homeMovie: homeMovie)
                        }
                        .disabled(homeMovie.isPlaceholder)
                    }
                }
                .tag(movieGroup.category)
                .onFirstAppear {
                    didFirstAppear(movieGroup)
                }
            }
            .padding(.horizontal)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
}

struct HomeCategoriesHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewContainer()
    }

    struct PreviewContainer: View {
        @State private var category: MovieCategory = .nowPlaying

        var body: some View {
            HomeSecondaryGridView(
                selectedCategory: $category,
                categoryGroups: [
                    .sample(forCategory: .nowPlaying),
                    .sample(forCategory: .upcoming),
                    .sample(forCategory: .topRated)
                ]
            ) { _ in }
        }
    }
}
