//
//  AddChevronViewModifier.swift
//  MoviesApp
//
//  Created by Leonardo on 9/22/24.
//

import SwiftUI

struct AddChevronViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        HStack {
            content
            Spacer()
            Image.chevronRight
        }
    }
}

extension View {
    func addChevron() -> some View {
        modifier(AddChevronViewModifier())
    }
}
