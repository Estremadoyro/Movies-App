//
//  NetworkManager.swift
//  MoviesApp
//
//  Created by Leonardo on 9/21/24.
//

import Combine
import Foundation

final class NetworkManager {
    static let shared = NetworkManager()

    private init() {}

    private lazy var session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()

    /// MUST be a .background queue or it will finish before emiting a value.
    private static let queue = DispatchQueue(label: "network_queue", qos: .background)

    func request<T: Decodable>(type: T.Type, endpoint: EndpointType) -> AnyPublisher<T, NetworkServiceError> {
        guard let baseURL = URL(string: endpoint.host) else {
            let error: NetworkServiceError = .invalidHost
            Logger.log(.network, .error, msg: error.localizedDescription)
            return Fail(error: error).eraseToAnyPublisher()
        }

        var urlComponents = URLComponents(url: baseURL.appendingPathComponent(endpoint.path), resolvingAgainstBaseURL: true)
        if let queryParams = endpoint.queryParams {
            urlComponents?.queryItems = queryParams.map { .init(name: $0.key, value: $0.value) }
        }

        guard let url = urlComponents?.url else {
            let error: NetworkServiceError = .badURL
            Logger.log(.network, .error, msg: error.localizedDescription)
            return Fail(error: error).eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.headers
        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
        }
        request.addContentTypeIfNeeded()

        let absoluteURL = request.url?.absoluteString ?? ""
        Logger.log(.network, .other, msg: "Requesting from: \(absoluteURL)")

        return session.dataTaskPublisher(for: request)
            .tryCatch { (error) -> AnyPublisher<(data: Data, response: URLResponse), NetworkServiceError> in
                let serviceError: NetworkServiceError

                let urlError = error as URLError
                switch urlError.code {
                case .notConnectedToInternet:
                    serviceError = .network(.noInternet)
                case .timedOut:
                    serviceError = .network(.timeout)
                case .cannotFindHost:
                    serviceError = .invalidHost
                default:
                    serviceError = .network(.other(code: urlError.errorCode, msg: urlError.localizedDescription))
                }

                Logger.log(.network, .error, msg: serviceError.localizedDescription)
                throw serviceError
            }
            .tryMap { (data, response) -> T in
                guard let response = response as? HTTPURLResponse else {
                    let error: NetworkServiceError = .invalidResponse
                    Logger.log(.network, .error, msg: error.localizedDescription)
                    throw error
                }

                if !NetworkError.allowedCodesRange.contains(response.statusCode) {
                    let error: NetworkServiceError = .network(.other(code: response.statusCode, msg: "Invalid status code"))
                    Logger.log(.network, .error, msg: error.localizedDescription)
                    throw error
                }

                do {
                    let json = try data.toModel(T.self)
                    Logger.log(.network, .success, msg: "Retrieved from: \(absoluteURL)")
                    return json
                } catch {
                    let error: NetworkServiceError = .decoding
                    Logger.log(.network, .error, msg: error.localizedDescription)
                    throw error
                }
            }
            .timeout(.seconds(endpoint.timeoutSeconds), scheduler: Self.queue) {
                let error: NetworkServiceError = .network(.timeout)
                Logger.log(.network, .error, msg: error.localizedDescription)
                return error
            }
            .mapError { $0 as? NetworkServiceError ?? .unknown }
            .subscribe(on: Self.queue)
            .eraseToAnyPublisher()
    }
}
