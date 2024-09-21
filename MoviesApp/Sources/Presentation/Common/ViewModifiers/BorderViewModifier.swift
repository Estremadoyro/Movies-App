//
//  BorderViewModifier.swift
//  MoviesApp
//
//  Created by Leonardo on 9/21/24.
//

import SwiftUI

struct BorderViewModifier: ViewModifier {
    var color: Color
    var width: CGFloat
    var radius: CGFloat

    func body(content: Content) -> some View {
        content
            .overlay {
                RoundedRectangle(cornerRadius: radius)
                    .stroke(color, lineWidth: width)
            }
            .addCornerRadius(radius: radius)
    }
}

// MARK: - View+Extension
extension View {
    @ViewBuilder
    func addBorder(color: Color = .gray,
                   width: CGFloat = 1,
                   radius: CGFloat = 0) -> some View {
        self.modifier(
            BorderViewModifier(
                color: color,
                width: width,
                radius: radius
            )
        )
    }
}
