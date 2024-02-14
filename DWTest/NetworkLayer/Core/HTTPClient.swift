//
//  HTTPClient.swift
//  DWTest
//
//  Created by Denis Windover on 14/02/2024.
//

import Foundation
import UIKit


enum RequestMethod: String {
    case delete = "DELETE"
    case get = "GET"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
}


protocol HTTPClient {
    func request<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async -> Result<T?, RequestError>
}

extension HTTPClient {
    func request<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async -> Result<T?, RequestError> {

            guard let url = URL(string: endpoint.baseURL + endpoint.path) else {
                return .failure(.invalidURL)
            }

            var request = URLRequest(url: url)
            request.httpMethod = endpoint.method.rawValue
            request.allHTTPHeaderFields = endpoint.header
            
            if let body = endpoint.body, let httpBody = try? JSONSerialization.data(withJSONObject: body, options: []) {
                request.httpBody = httpBody
            }

            do {
                let (data, response) = try await URLSession.shared.data(for: request)
            
                debugRequest(request, with: data)
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    return .failure(.noResponse)
                }
                
                guard (200...299).contains(httpResponse.statusCode) else {
                    return .failure(RequestError.error(fromStatusCode: httpResponse.statusCode))
                }
                
                do {
                    let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                    return .success(decodedResponse)
                } catch {
                    debugPrint("Decoding error: \(error)")
                    return .failure(.decode)
                }
                
            } catch {
                return .failure(.badRequest(error))
            }
        }
    
    private func debugRequest(_ request: URLRequest, with data: Data) {
#if DEBUG
        print("Request URL: \(request.url?.absoluteString ?? "N/A")")
        print("Method: \(request.httpMethod ?? "N/A")")
        print("Request Headers: \(request.allHTTPHeaderFields ?? [:])")
        print("Response: \(String(data: data, encoding: .utf8) ?? "N/A")")
#endif
    }
    
}
