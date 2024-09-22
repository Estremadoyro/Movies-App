//
//  MovieDetailView.swift
//  MoviesApp
//
//  Created by Leonardo on 9/22/24.
//

import SwiftUI

struct MovieDetailView: View {
    @StateObject var viewModel: MovieDetailViewModel

    var body: some View {
        makeContentView()
            .navigationTitle("Detail")
            .navigationBarTitleDisplayMode(.inline)
            .addToolBarItem(placement: .topBarTrailing, view: makeWatchListView, action: viewModel.didChangeWatchListStatus())
            .onFirstAppear {
                viewModel.onFirstAppear()
            }
            .sheet(isPresented: $viewModel.showSheet) {
                viewModel.destination.makeView()
            }
    }

    @ViewBuilder
    func makeWatchListView() -> some View {
        let image: Image = viewModel.isInWatchList ? .bookmarkFill : .bookmark
        image
            .resizable()
            .renderingMode(.template)
            .frame(width: 18, height: 24)
            .foregroundStyle(Color.appPrimaryColor)
    }
}

// MARK: - Content
private extension MovieDetailView {
    func makeContentView() -> some View {
        VStack(spacing: -60) {
            makeTrailerView()
            makeInformationView()
            Spacer()
        }
    }
}

// MARK: - Trailer
private extension MovieDetailView {
    @ViewBuilder
    func makeTrailerView() -> some View {
        let size = CGSize(width: screenSize.width, height: 211)
        ZStack {
            if let url = viewModel.movie.backdropURL {
                RemoteImage(url: url, config: .init(size: size), imageAspect: .aspectFill)
                if let youtubeURL = viewModel.movie.youtubeURL {
                    makeTrailerPlayButton(url: youtubeURL)
                }
            } else {
                RemoteImage.makeImageErrorView()
                    .addCornerRadius(topLeft: 0, bottomLeft: 16, bottomRight: 16, topRight: 0)
            }
        }
        .frame(width: size.width, height: size.height)
        .addCornerRadius(topLeft: 0, bottomLeft: 16, bottomRight: 16, topRight: 0)
    }

    func makeTrailerPlayButton(url: URL?) -> some View {
        SafeButton {
            viewModel.openTrailerView(url: url)
        } label: {
            Image.playFill
                .renderingMode(.template)
                .font(.system(size: 40))
                .foregroundStyle(.white)
                .padding(.vertical, 16)
                .padding(.horizontal, 32)
                .background(.red)
                .addCornerRadius(radius: 16)
                .shadow(color: .red, radius: 4)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Information
private extension MovieDetailView {
    func makeInformationView() -> some View {
        VStack(spacing: 28) {
            makeTitleWithImage()
            HomeDetailHeaderView(isLoading: viewModel.isLoading, movie: viewModel.movie)
            makeOverviewView()
        }
        .padding(.horizontal)
    }

    func makeTitleWithImage() -> some View {
        HStack(spacing: 8) {
            makeTitleImageView()
            VStack {
                Spacer()
                makeTitleView()
            }
            .padding(.bottom, 8)
            Spacer()
        }
        .frame(height: 128)
    }

    @ViewBuilder
    func makeTitleView() -> some View {
        if let title = viewModel.movie.title {
            Text(title)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                .font(.title3)
                .bold()
        }
    }

    @ViewBuilder
    func makeTitleImageView() -> some View {
        let imageSize = CGSize(width: 95, height: 120)
        if let url = viewModel.movie.posterURL {
            RemoteImage(url: url, config: .init(size: imageSize), imageAspect: .aspectFill)
                .frame(width: imageSize.width, height: imageSize.height)
                .addCornerRadius(radius: 16)
        }
    }

    @ViewBuilder
    func makeOverviewView() -> some View {
        if let overview = viewModel.movie.overview {
            // TODO: Improve scroll as it doesn't have a height defined
            ScrollView(.vertical) {
                Text(overview)
                    .redacted(reason: viewModel.isLoading ? .placeholder : [])
            }
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        MovieDetailViewBuilder.build(movie: .sample, mock: true)
    }
}
