//
//  MovieCellSearch.swift
//  MoviesApp
//
//  Created by Leonardo on 9/21/24.
//

import SwiftUI

struct MovieCellHorizontal: View {
    var movie: Movie

    private var imgSize: CGSize {
        let ratio = 1.263
        let width: Double = screenSize.width * (95.0 / 375.0)
        let height = width * ratio
        return CGSize(width: width, height: height)
    }

    var body: some View {
        makeContentView()
            .frame(height: imgSize.height)
    }

    func makeContentView() -> some View {
        HStack(spacing: 16) {
            makeImageView()
                .frame(width: imgSize.width, height: imgSize.height)
                .addCornerRadius(radius: 16)
            VStack(alignment: .leading, spacing: .zero) {
                if let title = movie.title {
                    Text(title)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                        .font(.title3)
                        .bold()
                        .fixedSize(horizontal: false, vertical: true)
                }
                Spacer()
                VStack(alignment: .leading, spacing: 8) {
                    if let voteAverage = movie.voteAverage {
                        HStack(spacing: 4) {
                            Image.star
                                .renderingMode(.template)
                            Text(String(format: "%0.1f", voteAverage))
                        }
                        .foregroundStyle(.orange)
                        .bold()
                    }
                    if let releaseDate = movie.dateYearOnly {
                        HStack(spacing: 4) {
                            Image.calendar
                                .resizable()
                                .renderingMode(.template)
                                .frame(width: 20, height: 20)
                            Text(releaseDate)
                        }
                    }
                }
            }
            .padding(.vertical, 4)
            Spacer()
        }
    }

    @ViewBuilder
    func makeImageView() -> some View {
        if let imgURL = movie.posterURL {
            RemoteImage(
                url: imgURL,
                config: .default,
                imageAspect: .aspectFill
            )
        } else {
            RemoteImage.makeImageErrorView()
        }
    }
}

#Preview {
    MovieCellHorizontal(movie: .sample)
        .padding(.horizontal)
}
