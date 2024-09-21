//
//  String+Extension.swift
//  MoviesApp
//
//  Created by Leonardo on 9/21/24.
//

import Foundation

extension String {
    static let empty: String = ""

    func toModel<T: Decodable>(type: T.Type) -> T? {
        guard let jsonData = self.data(using: .utf8) else { return nil }
        do {
            let model = try JSONDecoder().decode(type, from: jsonData)
            return model
        } catch {
            Logger.log(.local, .error, msg: "Error decoding JSON: \(error)")
            return nil
        }
    }
}
