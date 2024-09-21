//
//  TabItemViewModifier.swift
//  MoviesApp
//
//  Created by Leonardo on 9/20/24.
//

import SwiftUI

struct TabItemViewModifier: ViewModifier {
    var index: Int
    var selectedIndex: Int
    var title: String
    var img: Image
    var imgSelected: Image

    func body(content: Content) -> some View {
        content
            .tabItem {
                Label(
                    title: { Text(title) },
                    icon: { index == selectedIndex ? imgSelected : img }
                )
                .environment(\.symbolVariants, .none)
            }
            .tag(index)
    }
}

extension View {
    func addTabItem(index: Int, selectedIndex: Int, title: String, img: Image, imgSelected: Image) -> some View {
        modifier(TabItemViewModifier(index: index,
                                     selectedIndex: selectedIndex,
                                     title: title,
                                     img: img,
                                     imgSelected: imgSelected)
        )
    }
}
