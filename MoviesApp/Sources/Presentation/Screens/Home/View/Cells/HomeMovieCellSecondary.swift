//
//  HomeMovieCellSecondary.swift
//  MoviesApp
//
//  Created by Leonardo on 9/21/24.
//

import SwiftUI

struct HomeMovieCellSecondary: View {
    var homeMovie: HomeMovie

    private var size: CGSize {
        let height: Double = screenSize.height * 0.18
        let width: Double = height * 0.689
        return CGSize(width: width, height: height)
    }

    var body: some View {
        Group {
            if homeMovie.isPlaceholder {
                RemoteImage.makePlaceholderView()
            } else {
                makeContentView()
            }
        }
        .frame(width: size.width, height: size.height)
        .addCornerRadius(radius: 16)
    }
}

// MARK: - Content
private extension HomeMovieCellSecondary {
    @ViewBuilder
    func makeContentView() -> some View {
        if let url = homeMovie.movie.posterURL {
            let config = RemoteImageConfig(size: size)
            RemoteImage(url: url, config: config, imageAspect: .aspectFill)
        }
    }
}

// MARK: - Preview
#Preview {
    HomeMovieCellSecondary(homeMovie: .sample)
}
