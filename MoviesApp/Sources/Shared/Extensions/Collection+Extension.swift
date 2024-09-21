//
//  Collection+Extension.swift
//  MoviesApp
//
//  Created by Leonardo on 9/21/24.
//

import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

extension MutableCollection {
    subscript(safe index: Index) -> Element? {
        get {
            return indices.contains(index) ? self[index] : nil
        }

        set(newValue) {
            if let newValue = newValue, indices.contains(index) {
                self[index] = newValue
            }
        }
    }
}

extension MutableCollection where Element: Identifiable {
    mutating func update<T>(element: Element, update: UpdateWrapper<Element, T>) {
        guard let index = self.firstIndex(where: { $0.id == element.id }) else { return }

        var updated = self[index]
        updated[keyPath: update.property] = update.newValue

        self[index] = updated
    }
}
