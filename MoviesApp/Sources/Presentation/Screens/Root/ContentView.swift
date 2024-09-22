//
//  ContentView.swift
//  MoviesApp
//
//  Created by Leonardo on 9/20/24.
//

import SwiftUI

struct ContentView: View {
    @State private var index: Int = 0
    private let tabs: [MainTab] = MainTab.allCases

    var body: some View {
        TabView(selection: $index) {
            ForEach(tabs) { (tab) in
                tab.makeView()
                    .tag(tab.id)
                    .tabItem {
                        Label(
                            title: { Text(tab.title) },
                            icon: { tab.icon }
                        )
                        .environment(\.symbolVariants, .none)
                    }
                    .tint(.appPrimaryColor)
            }
        }
        .scrollDismissesKeyboard(.immediately)
    }
}

#Preview {
    ContentView()
}
