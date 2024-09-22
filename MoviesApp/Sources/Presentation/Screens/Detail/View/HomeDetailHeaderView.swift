//
//  HomeDetailHeaderView.swift
//  MoviesApp
//
//  Created by Leonardo on 9/22/24.
//

import SwiftUI

struct HomeDetailHeaderView: View {
    var isLoading: Bool
    var movie: Movie

    var body: some View {
        HStack(spacing: 8) {
            if let dateYearOnly = movie.dateYearOnly {
                HStack(spacing: 4) {
                    Image.calendar
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 20, height: 20)
                    Text(dateYearOnly)
                }
            }

            if let runtime = movie.runtime {
                Color.gray
                    .frame(width: 1, height: 20)
                HStack(spacing: 4) {
                    Image.clock
                    Text("\(runtime) Minutes")
                        .redacted(reason: isLoading ? .placeholder : [])
                }
            }

            if let mainGenre = movie.mainGenre {
                Color.gray
                    .frame(width: 1, height: 20)
                HStack(spacing: 4) {
                    Image.ticket
                    Text(mainGenre.name)
                        .redacted(reason: isLoading ? .placeholder : [])
                }
            }
        }
        .foregroundStyle(.gray)
    }
}

#Preview {
    HomeDetailHeaderView(isLoading: true, movie: .sampleDetail)
}
