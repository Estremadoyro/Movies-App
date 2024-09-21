//
//  ToolBarItemViewModifier.swift
//  MoviesApp
//
//  Created by Leonardo on 9/20/24.
//

import SwiftUI

struct ToolBarItemViewModifier<T: View>: ViewModifier {
    var view: () -> T
    var placement: ToolbarItemPlacement
    var hidden: Bool
    var action: (() -> Void)?

    func body(content: Content) -> some View {
        content
            .toolbar {
                if !hidden {
                    ToolbarItem(placement: placement) {
                        if let action {
                            Button {
                                action()
                            } label: {
                                view()
                            }
                        } else {
                            view()
                        }
                    }
                }
            }
    }
}

extension View {
    func addToolBarItem<T: View>(placement: ToolbarItemPlacement, hidden: Bool = false, view: @escaping () -> T, _ action: (() -> Void)? = nil) -> some View {
        modifier(ToolBarItemViewModifier(view: view, placement: placement, hidden: hidden, action: action))
    }

    func addToolBarItem<T: View>(placement: ToolbarItemPlacement, hidden: Bool = false, view: @escaping @autoclosure () -> T, _ action: (() -> Void)? = nil) -> some View {
        modifier(ToolBarItemViewModifier(view: view, placement: placement, hidden: hidden, action: action))
    }

    func addToolBarItem<T: View>(placement: ToolbarItemPlacement, hidden: Bool = false, view: @escaping () -> T, action: @escaping @autoclosure () -> Void) -> some View {
        modifier(ToolBarItemViewModifier(view: view, placement: placement, hidden: hidden, action: action))
    }

    func addToolBarItem<T: View>(placement: ToolbarItemPlacement, hidden: Bool = false, view: @escaping @autoclosure () -> T, action: @escaping @autoclosure () -> Void) -> some View {
        modifier(ToolBarItemViewModifier(view: view, placement: placement, hidden: hidden, action: action))
    }
}
