//
//  RequestError.swift
//  DWTest
//
//  Created by Denis Windover on 14/02/2024.
//

import Foundation

enum RequestError: Error {
    case decode
    case invalidURL
    case noResponse
    case badRequest(Error)
    case unexpectedStatusCode(Int)
    case unknown
    
}

extension RequestError: CustomStringConvertible {
    var description: String {
        switch self {
        case .decode:
            return "Unable to decode the response."
        case .invalidURL:
            return "The URL provided was invalid."
        case .noResponse:
            return "No response was received from the server."
        case .badRequest(let error):
            return "Bad request: \(error.localizedDescription)"
        case .unexpectedStatusCode:
            return "Unexpected status code received."
        case .unknown:
            return "An unknown error occurred."
        }
    }
}

extension RequestError {
    var localizedDescription: String {
        return NSLocalizedString(description, comment: "")
    }
}

extension RequestError {
    static func error(fromStatusCode code: Int) -> RequestError {
        switch code {
        case 400...499:
            return .badRequest(NSError(domain: "Bad Request", code: code, userInfo: nil))
        case 500...599:
            return .unexpectedStatusCode(code)
        default:
            return .unknown
        }
    }
}
