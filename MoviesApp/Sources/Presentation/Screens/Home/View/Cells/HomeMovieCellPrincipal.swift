//
//  HomeMoviewCellPrincipal.swift
//  MoviesApp
//
//  Created by Leonardo on 9/21/24.
//

import SwiftUI

struct HomeMovieCellPrincipal: View {
    var position: Int
    var homeMovie: HomeMovie

    let size = CGSize(width: 160, height: 244)
    let imgSize = CGSize(width: 144.61, height: 210)
    let cornerRadius: Double = 16

    var body: some View {
        makeContentView()
            .frame(width: size.width, height: size.height)
    }
}

// MARK: - Content
private extension HomeMovieCellPrincipal {
    func makeContentView() -> some View {
        ZStack {
            Group {
                if homeMovie.isPlaceholder {
                    RemoteImage.makePlaceholderView()
                } else {
                    makeImageView()
                }
            }
            .frame(width: imgSize.width, height: imgSize.height)
            .addCornerRadius(radius: cornerRadius)
            VStack {
                Spacer()
                HStack {
                    Text("\(position)")
                        .redacted(reason: homeMovie.isPlaceholder ? .placeholder : [])
                        .fontWeight(.heavy)
                        .lineLimit(1)
                        .foregroundStyle(.dynamicBlack.opacity(0.9))
                        .font(.principalMoviePosition)
                        .shadow(color: .dynamicWhite, radius: 2)
                        .offset(y: 24)
                    Spacer()
                }
                .offset(x: -4)
            }
        }
        .padding(.vertical, 4)
    }

    @ViewBuilder
    func makeImageView() -> some View {
        if let url = homeMovie.movie.posterURL {
            let config = RemoteImageConfig(size: imgSize)
            RemoteImage(url: url, config: config, imageAspect: .aspectFill)
        } else {
            RemoteImage.makeImageErrorView()
        }
    }
}

// MARK: - Preview
#Preview {
    HomeMovieCellPrincipal(position: 3, homeMovie: .sample)
}
