//
//  HomeMovieView.swift
//  MoviesApp
//
//  Created by Leonardo on 9/21/24.
//

import SwiftUI

struct HomeMovieView: View {
    var section: HomeSectionType
    var homeMovie: HomeMovie

    var body: some View {
        switch section {
        case .principal:
            makeMovieViewForSectionPrincpial()
        case .secondary:
            makeMovieViewForSectionSecondary()
        }
    }
}

// MARK: - Principal
private extension HomeMovieView {
    @ViewBuilder
    func makeMovieViewForSectionPrincpial() -> some View {
        if let imageURL = homeMovie.movie.posterURL {
            AsyncImage(
                url: imageURL,
                transaction: Transaction(animation: .easeIn)
            ) { (phase) in
                switch phase {
                case let .success(image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipped()
                case .empty:
                    Color.gray
                default:
                    Text("error img")
                }
            }
            .frame(width: 144, height: 210)
            .addCornerRadius(radius: 16)
        }
    }
}

// MARK: - Principal
private extension HomeMovieView {
    func makeMovieViewForSectionSecondary() -> some View {
        Text("movie secondary cell")
    }
}

// MARK: - Preview
#Preview {
    HomeMovieView(section: .principal, homeMovie: .sample)
}
