//
//  HomeCategoriesHeaderView.swift
//  MoviesApp
//
//  Created by Leonardo on 9/21/24.
//

import SwiftUI

struct HomeCategoriesHeaderView: View {
    @Binding var selectedCategory: MovieCategory
    var categories: [MovieCategory]

    var body: some View {
        HStack {
            ForEach(Array(categories.enumerated()), id: \.element) { (i, category) in
                SafeButton {
                    selectedCategory = category
                } label: {
                    ZStack {
                        Text(category.title)
                            .foregroundColor(.primary)
                            .lineLimit(1)
                        VStack {
                            Spacer()
                            if category == selectedCategory {
                                Color.gray
                                    .frame(width: screenSize.width * 0.2, height: 4)
                            }
                        }
                    }
                    .frame(width: screenSize.width * 0.3, height: 40)
                }
                .buttonStyle(.plain)
                if i < categories.count - 1 {
                    Spacer()
                }
            }
        }
        .bold()
    }
}

#Preview {
    HomeCategoriesHeaderView(
        selectedCategory: .constant(.nowPlaying),
        categories: [.nowPlaying, .upcoming, .popular]
    )
}
