//
//  NetworkServiceError.swift
//  MoviesApp
//
//  Created by Leonardo on 9/21/24.
//

import Foundation

enum NetworkServiceError: LocalizedError {
    case invalidResponse
    case invalidHost
    case badURL
    case decoding
    case network(NetworkError)
    case unknown

    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "Invalid response"
        case .invalidHost:
            return "Invalid host"
        case .badURL:
            return "Bad URL"
        case .decoding:
            return "Decoding failed"
        case let .network(networkError):
            return "Network Error (\(networkError.errorDescription ?? "?"))"
        case .unknown:
            return "Unknown service error"
        }
    }
}
