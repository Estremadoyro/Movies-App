//
//  Movie.swift
//  MoviesApp
//
//  Created by Leonardo on 9/21/24.
//

import Foundation

struct Movie: Identifiable, Hashable {
    var id: String
    var title: String?

    init(id: String, title: String? = nil) {
        self.id = id
        self.title = title
    }
}
