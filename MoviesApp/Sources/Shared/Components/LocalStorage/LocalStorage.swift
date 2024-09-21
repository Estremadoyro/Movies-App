//
//  LocalStorage.swift
//  MoviesApp
//
//  Created by Leonardo on 9/21/24.
//

import Foundation

@propertyWrapper
struct LocalStorage<Value> {
    private let storage = UserDefaults.standard

    let key: KeyPath<LocalKeys, String>
    var wrappedValue: Value? {
        get { load() }
        set { save(value: newValue) }
    }
    
    init(_ key: KeyPath<LocalKeys, String>) {
        self.key = key
    }

    private func load() -> Value? {
        let key = LocalKeys()[keyPath: key]
        guard let value = storage.value(forKey: key) as? Value else {
            Logger.log(.local, .error, msg: "Not found: .\(key)")
            return nil
        }
        Logger.log(.local, .success, msg: "Retrieved: [\(key): \(value)]")
        return value
    }

    private func save(value: Value?) {
        let key = LocalKeys()[keyPath: key]
        storage.set(value, forKey: key)
        Logger.log(.local, .success, msg: "Saved: [\(key): \(String(describing: value))]")
    }
}
