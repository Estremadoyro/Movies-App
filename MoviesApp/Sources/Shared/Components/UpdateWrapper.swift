//
//  UpdateWrapper.swift
//  MoviesApp
//
//  Created by Leonardo on 9/21/24.
//

import Foundation

/// Useful to "update" (Re-create with changes values) structs.
struct UpdateWrapper<Model, Value> {
    var property: WritableKeyPath<Model, Value>
    var newValue: Value
}
