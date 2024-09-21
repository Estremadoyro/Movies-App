//
//  FileReader.swift
//  MoviesApp
//
//  Created by Leonardo on 9/21/24.
//

import Foundation

enum FileReader {
    static func read(filename: String, type: String = "txt") -> String? {
        guard let path = Bundle.main.path(forResource: filename, ofType: type) else {
            Logger.log(.local, .error, msg: "File not found")
            return nil
        }

        do {
            let jsonString = try String(contentsOfFile: path, encoding: .utf8)
            return jsonString
        } catch {
            Logger.log(.local, .error, msg: "Error reading file: \(error)")
            return nil
        }
    }
}
