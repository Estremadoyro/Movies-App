//
//  RemoteImage.swift
//  MoviesApp
//
//  Created by Leonardo on 9/21/24.
//

import SwiftUI

enum RemoteImageAspect {
    case aspectFill
    case custom((Image) -> AnyView)
}

struct RemoteImageConfig {
    var size: CGSize

    static let `default` = RemoteImageConfig(size: CGSize(width: 144, height: 210))
}

struct RemoteImage: View {
    var url: URL?
    var config: RemoteImageConfig

    var onImageReceived: (Image) -> AnyView
    var onImagePlaceholder: () -> AnyView
    var onImageError: () -> AnyView

    init(url: URL?,
         config: RemoteImageConfig,
         imageAspect: RemoteImageAspect,
         @ViewBuilder onImagePlaceholder: @escaping () -> some View = { Self.makePlaceholderView() },
         @ViewBuilder onImageError: @escaping () -> some View = { Self.makeImageErrorView() }) {
        self.url = url
        self.config = config

        self.onImageReceived = { (image) in
            switch imageAspect {
            case .aspectFill:
                return AnyView(
                    image
                        .resizable()
                        .frame(width: config.size.width, height: config.size.height)
                        .aspectRatio(contentMode: .fill)
                        .clipped()
                )
            case let .custom(receivedImage):
                return receivedImage(image)
            }
        }
        self.onImagePlaceholder = { AnyView(onImagePlaceholder()) }
        self.onImageError = { AnyView(onImageError()) }
    }

    var body: some View {
        Group {
            if let url {
                AsyncImage(
                    url: url,
                    transaction: Transaction(animation: .easeIn)
                ) { (phase) in
                    switch phase {
                    case let .success(image):
                        onImageReceived(image)
                    case .empty:
                        onImagePlaceholder()
                    default:
                        onImageError()
                    }
                }
            } else {
                onImageError()
            }
        }
        .frame(width: config.size.width, height: config.size.height)
    }

    static func makeImageErrorView() -> some View {
        ZStack {
            Color.gray.opacity(0.6)
            VStack(spacing: 8) {
                Image.photo
                    .renderingMode(.template)
                    .foregroundStyle(.white)
                    .font(.system(size: 28))
                Text("No Image")
                    .font(.caption)
                    .foregroundStyle(.white)
            }
            .bold()
        }
        .addBorder(color: .gray, width: 4, radius: 16)
    }

    static func makePlaceholderView() -> some View {
        Color.gray
    }
}

#Preview {
    RemoteImage(
        url: URL(string: "XD https://image.tmdb.org/t/p/w500/8cdWjvZQUExUUTzyp4t6EDMubfO.jpg"),
        config: .default,
        imageAspect: .aspectFill
    )
}
