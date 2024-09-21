//
//  URLRequest+Extension.swift
//  MoviesApp
//
//  Created by Leonardo on 9/21/24.
//

import Foundation

extension URLRequest {
    mutating func addContentTypeIfNeeded() {
        if value(forHTTPHeaderField: "Content-Type") == nil {
            setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        if value(forHTTPHeaderField: "accept") == nil {
            setValue("application/json", forHTTPHeaderField: "accept")
        }
    }
}
