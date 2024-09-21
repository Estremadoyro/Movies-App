//
//  NetworkError.swift
//  MoviesApp
//
//  Created by Leonardo on 9/21/24.
//

import Foundation

enum NetworkError: LocalizedError {
    case badRequest
    case rateLimitted
    case serverBusy
    case timeout
    case noInternet
    case other(code: Int, msg: String)

    var errorDescription: String? {
        let desc: String
        switch self {
        case .badRequest:
            desc = "Bad request"
        case .rateLimitted:
            desc = "Rate limit reached"
        case .serverBusy:
            desc = "Server error"
        case .timeout:
            desc = "Request timmed out"
        case .noInternet:
            desc = "No internet"
        case let .other(_, msg):
            desc = msg
        }
        return "\(desc) (\(code))"
    }

    var code: Int {
        switch self {
        case .badRequest:
            return 400
        case .rateLimitted:
            return 429
        case .serverBusy:
            return 503
        case .timeout:
            return 408
        case .noInternet:
            return 502
        case let .other(code, _):
            return code
        }
    }

    static let allowedCodesRange: Range<Int> = 200 ..< 300
}
