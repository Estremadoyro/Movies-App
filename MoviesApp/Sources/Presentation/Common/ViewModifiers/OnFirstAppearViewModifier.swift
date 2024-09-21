//
//  OnFirstAppearViewModifier.swift
//  MoviesApp
//
//  Created by Leonardo on 9/21/24.
//

import SwiftUI

/*
 Run an action only on the first appear of the view in its lifeycle.
 */
struct OnFirstAppearViewModifier: ViewModifier {
    @State private var didAppear: Bool = false
    var action: () -> Void

    func body(content: Content) -> some View {
        content
            .onAppear {
                guard !didAppear else { return }
                DispatchQueue.main.async {
                    action()
                }
                didAppear = true
            }
    }
}

extension View {
    func onFirstAppear(_ action: @escaping () -> Void) -> some View {
        return modifier(OnFirstAppearViewModifier(action: action))
    }
}
