//
//  Decodable+Extension.swift
//  MoviesApp
//
//  Created by Leonardo on 9/21/24.
//

import Foundation

extension Data {
    func toModel<Model: Decodable>(_ model: Model.Type) throws -> Model {
        do {
            let decoder = JSONDecoder()
            let json = try decoder.decode(Model.self, from: self)
            Logger.log(.coding, .success, msg: "Decoded \(String(describing: model))")
            return json
        } catch {
            Logger.log(.coding, .error, msg: "Error: \(String(describing: error))")
            throw error
        }
    }
}
