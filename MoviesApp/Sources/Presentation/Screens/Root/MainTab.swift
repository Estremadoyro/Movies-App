//
//  MainTab.swift
//  MoviesApp
//
//  Created by Leonardo on 9/20/24.
//

import SwiftUI

enum MainTab: Int, Identifiable, Hashable, CaseIterable {
    case home = 0
    case search
    case watchList
    case settings

    var id: Int { self.rawValue }

    var title: String {
        switch self {
        case .home:
            return "Home"
        case .search:
            return "Search"
        case .watchList:
            return "Watch List"
        case .settings:
            return "Settings"
        }
    }

    var icon: Image {
        switch self {
        case .home:
            return .house
        case .search:
            return .magnifyingglass
        case .watchList:
            return .bookmark
        case .settings:
            return .gear
        }
    }

    @ViewBuilder
    func makeView() -> some View {
        switch self {
        case .home:
            HomeViewBuilder.build()
        case .search:
            Text("Search")
        case .watchList:
            Text("watch liset")
        case .settings:
            SettingsView()
        }
    }
}
