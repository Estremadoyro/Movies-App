//
//  SettingsViewModel.swift
//  MoviesApp
//
//  Created by Leonardo on 9/21/24.
//

import SwiftUI

final class SettingsViewModel: ObservableObject {
    @Published var debug: Bool = false {
        didSet { updateLocalStorage(key: \.debugMode, newValue: debug) }
    }

    init() {
        debug = LocalKeys.debugMode
    }
}

private extension SettingsViewModel {
    func updateLocalStorage<T>(key keypath: KeyPath<LocalKeys, String>, newValue: T) {
        @LocalStorage(keypath) var localValue: T?
        localValue = newValue
    }
}
