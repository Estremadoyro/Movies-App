//
//  MoviesEndpoint.swift
//  MoviesApp
//
//  Created by Leonardo on 9/20/24.
//

import Foundation

enum MoviesEndpoint: EndpointType {
    case getPopular(page: Int)
    
    var host: String { "https://api.themoviedb.org/3" }
    
    var headers: [String: String] {
        ["Authorization": "Bearer \(AppKeys.movieDbApiKey)"]
    }
    
    var method: HTTPMethod { .get }
    
    var path: String {
        switch self {
        case .getPopular:
            return "/movie/popular"
        }
    }
    
    var queryParams: [String: String]? {
        switch self {
        case let .getPopular(page):
            return ["page": "\(page)"]
        }
    }
}
