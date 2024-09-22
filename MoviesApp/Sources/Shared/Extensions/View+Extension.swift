//
//  View+Extension.swift
//  MoviesApp
//
//  Created by Leonardo on 9/21/24.
//

import SwiftUI

extension View {
    @ViewBuilder
    func addCornerRadius(radius: CGFloat) -> some View {
        self.clipShape(
            .rect(topLeadingRadius: radius,
                  bottomLeadingRadius: radius,
                  bottomTrailingRadius: radius,
                  topTrailingRadius: radius)
        )
    }
    
    func addCornerRadius(topLeft: Double, bottomLeft: Double, bottomRight: Double, topRight: Double) -> some View {
        self.clipShape(
            .rect(topLeadingRadius: topLeft,
                  bottomLeadingRadius: bottomLeft,
                  bottomTrailingRadius: bottomRight,
                  topTrailingRadius: topRight)
        )
    }
    
    var screenSize: CGSize { UIScreen.main.bounds.size }
}
