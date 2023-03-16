//
//  NetworkError.swift
//  AutomationTestApp
//
//  Created by Antoine Dufayet on 16/03/2023.
//

import Foundation

enum NetworkError: Error {
    case transportError(Error)
    case serverError(statusCode: Int)
    case noData
    case decodingError(Error)
}

extension NetworkError: Equatable {
    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.transportError, .transportError):
            return true
        case (.serverError, .serverError):
            return true
        case (.noData, .noData):
            return true
        case (.decodingError, .decodingError):
            return true
        default:
            return false
        }
    }
}
