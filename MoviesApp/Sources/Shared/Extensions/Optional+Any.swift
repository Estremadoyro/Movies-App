//
//  Optional+Any.swift
//  MoviesApp
//
//  Created by Leonardo on 9/21/24.
//

import Foundation

extension Optional where Wrapped: Any {
    var isNil: Bool { self == nil }
    var isNotNil: Bool { !self.isNil }
}
