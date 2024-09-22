//
//  Encodable+Extension.swift
//  MoviesApp
//
//  Created by Leonardo on 9/22/24.
//

import Foundation

extension Encodable {
    func toData() -> Data? {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(self)
            return data
        } catch {
            Logger.log(.coding, .error, msg: "Failed to encode \(self) to Data: \(error)")
            return nil
        }
    }
}

extension Array where Element: Encodable {
    func toData() -> Data? {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(self)
            return data
        } catch {
            Logger.log(.coding, .error, msg: "Failed to encode \(self) to Data: \(error)")
            return nil
        }
    }
}
