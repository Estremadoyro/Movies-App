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
            ScrollView(.vertical) {
                LazyVStack {
                    if let movies = viewModel.movies {
                        Text("movies count: \(movies.count)")
                    } else {
                        Text("No movies...")
                    }
                    SafeButton {
                        viewModel.onFirstAppear()
                    } label: {
                        Text("Fetch movies")
                    }
                }
            }
            .navigationTitle("What do you want to watch?")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(
                text: .constant(.empty),
                placement: .navigationBarDrawer(displayMode: .always)
            )
        }
    }
}

#Preview {
    HomeViewBuilder.build(mock: true)
}
