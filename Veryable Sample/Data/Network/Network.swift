//
//  Network.swift
//  Veryable Sample
//
//  Created by Fomagran on 2022/12/15.
//  Copyright © 2022 Veryable Inc. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case responseValidationFailed
    case responseSerializationFailed
    case error(reason: String)
    
    var reason: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .responseValidationFailed:
            return "Response validatino failed"
        case .responseSerializationFailed:
            return "Response serialization failed"
        case .error(let reason):
            return reason
        }
    }
}

