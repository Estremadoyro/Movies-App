//
//  LocalKeys.swift
//  MoviesApp
//
//  Created by Leonardo on 9/21/24.
//

import Foundation

struct LocalKeys {
    var debugMode: String { "debug_mode" }
    var testKey: String { "test_key" }
}

extension LocalKeys {
    static var debugMode: Bool {
        @LocalStorage(\.debugMode) var debugMode: Bool?
        #if DEBUG
        return debugMode ?? false
        #else
        return false
        #endif
    }
}
