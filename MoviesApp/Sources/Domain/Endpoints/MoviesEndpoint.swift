//
//  MoviesEndpoint.swift
//  MoviesApp
//
//  Created by Leonardo on 9/20/24.
//

import Foundation

enum MoviesEndpoint: EndpointType {
    case getPopular(page: Int)
    case getNowPlaying(page: Int)
    case getUpcoming(page: Int)
    case getTopRated(page: Int)
    
    var host: String { "https://api.themoviedb.org/3" }
    
    var headers: [String: String] {
        ["Authorization": "Bearer \(AppKeys.movieDbApiKey)"]
    }
    
    var method: HTTPMethod { .get }
    
    var path: String {
        switch self {
        case .getPopular:
            return "/movie/popular"
        case .getNowPlaying:
            return "/movie/now_playing"
        case .getUpcoming:
            return "/movie/upcoming"
        case .getTopRated:
            return "/movie/top_rated"
        }
    }
    
    var queryParams: [String: String]? {
        switch self {
        case let .getPopular(page),
             let .getNowPlaying(page),
             let .getUpcoming(page),
             let .getTopRated(page):
            return ["page": "\(page)"]
        }
    }
}
