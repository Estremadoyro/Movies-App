//
//  AppKeysTemplate.swift
//  MoviesApp
//
//  Created by Leonardo on 9/20/24.
//

import Foundation

// MARK: - Step 1
typealias AppKeys = AppKeysLocal       // 1.1 DELETE THIS LINE (11)
// typealias AppKeys = AppKeysTemplate // 1.2 UNCOMMENT THIS LINE

// MARK: - Step 2
enum AppKeysTemplate {
    /// Add your MovideDB API Key here.
    /// This must be the **Access Token Auth** as it will be added to as an Authorization header.
    static let movieDbApiKey = "[YOUR_MOVIE_DB_API_ACCESS_TOKEN]"
}
