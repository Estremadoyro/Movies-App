//
//  MovieCellHorizontalComponent.swift
//  MoviesApp
//
//  Created by Leonardo on 9/22/24.
//

import SwiftUI

enum MovieCellHorizontalComponent: Int, CaseIterable {
    case title = 0
    case score
    case genre
    case year
    case runtime

    @ViewBuilder
    func makeItem(movie: Movie, style: MovieCellHorizontalStyle) -> some View {
        switch self {
        case .title:
            if let title = movie.title {
                Text(title)
                    .multilineTextAlignment(.leading)
                    .lineLimit(style.titleLineLimit)
                    .font(style.titleFont)
                    .bold()
                    .fixedSize(horizontal: false, vertical: true)
            }
        case .score:
            if let voteAverage = movie.voteAverage {
                HStack(spacing: 4) {
                    Image.star
                        .renderingMode(.template)
                    Text(String(format: "%0.1f", voteAverage))
                }
                .foregroundStyle(.orange)
                .bold()
            }
        case .genre:
            if let genre = movie.mainGenre {
                HStack(spacing: 4) {
                    Image.ticket
                        .renderingMode(.template)
                    Text(genre.name)
                }
            }
        case .year:
            if let year = movie.dateYearOnly {
                let side: CGFloat = style == .detailed ? 16 : 20
                HStack(spacing: 4) {
                    Image.calendar
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: side * 1.1, height: side)
                    Text(year)
                }
            }
        case .runtime:
            if let runTime = movie.runtime {
                HStack(spacing: 4) {
                    Image.clock
                        .renderingMode(.template)
                    Text("\(runTime) minutes")
                }
            }
        }
    }
}
