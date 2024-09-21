//
//  EndpointType.swift
//  MoviesApp
//
//  Created by Leonardo on 9/20/24.
//

import Foundation

protocol EndpointType {
    var host: String { get }
    var headers: [String: String] { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var queryParams: [String: String]? { get }
    var timeoutSeconds: Int { get }
    var body: [String: Any]? { get }
}

extension EndpointType {
    var timeoutSeconds: Int { 60 }
    var body: [String: Any]? { nil }
}

enum HTTPMethod: String {
    case get    = "GET"
    case post   = "POST"
    case put    = "PUT"
    case patch  = "PATCH"
    case delete = "DELETE"
    case unknown
}
