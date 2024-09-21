//
//  SafeButton.swift
//  MoviesApp
//
//  Created by Leonardo on 9/21/24.
//

import SwiftUI

/*
 This button wrapper ensures any action is ran on the main-thread.
 */
struct SafeButton<Label: View>: View {
    var role: ButtonRole?
    var action: () -> Void
    var label: () -> Label

    var body: some View {
        Button(role: role) {
            DispatchQueue.main.async {
                action()
            }
        } label: {
            label()
        }
    }

    init(role: ButtonRole? = nil, action: @escaping () -> Void, @ViewBuilder label: @escaping () -> Label) {
        self.role = role
        self.action = action
        self.label = label
    }
}
