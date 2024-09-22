//
//  MovieCellSearch.swift
//  MoviesApp
//
//  Created by Leonardo on 9/21/24.
//

import SwiftUI

struct MovieCellHorizontal: View {
    var style: MovieCellHorizontalStyle
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
            VStack(alignment: .leading, spacing: 4) {
                ForEach(style.components, id: \.rawValue) { (component) in
                    if component == .title {
                        component.makeItem(movie: movie, style: style)
                        Spacer()
                    } else {
                        component.makeItem(movie: movie, style: style)
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
    MovieCellHorizontal(style: .simple, movie: .sampleDetail)
        .padding(.horizontal)
}
