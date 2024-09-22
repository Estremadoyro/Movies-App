//
//  Image+Extension.swift
//  MoviesApp
//
//  Created by Leonardo on 9/20/24.
//

import SwiftUI

extension Image {
    static let house = Image(systemName: "house")
    static let magnifyingglass = Image(systemName: "magnifyingglass")
    static let bookmark = Image(systemName: "bookmark")
    static let gear = Image(systemName: "gear")
    static let star = Image(systemName: "star")
    static let calendar = Image(.calendar)
    static let noResults = Image(.noResults)
    static let photo = Image(systemName: "photo")
    static let clock = Image(systemName: "clock")
    static let ticket = Image(systemName: "ticket")
    static let playFill = Image(systemName: "play.fill")
    static var chevronRight: some View {
        Image(systemName: "chevron.right")
            .renderingMode(.template)
            .foregroundStyle(.gray)
    }

    // Fill
    static let bookmarkFill = Image(systemName: "bookmark.fill")
    static let xMarkCircleFill = Image(systemName: "xmark.circle.fill")
}
