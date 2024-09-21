//
//  HomeMovieCellSecondary.swift
//  MoviesApp
//
//  Created by Leonardo on 9/21/24.
//

import SwiftUI

struct HomeMovieCellSecondary: View {
    var homeMovie: HomeMovie

    var body: some View {
        makeContentView()
    }
}

// MARK: - Content
private extension HomeMovieCellSecondary {
    @ViewBuilder
    func makeContentView() -> some View {
        let size = CGSize(width: 100, height: 145.92)
        Group {
            if let url = homeMovie.movie.posterURL {
                let config = RemoteImageConfig(size: size)
                RemoteImage(url: url, config: config, imageAspect: .aspectFill)
            }
        }
        .frame(width: size.width, height: size.height)
    }
}

// MARK: - Preview
#Preview {
    HomeMovieCellSecondary(homeMovie: .sample)
}
