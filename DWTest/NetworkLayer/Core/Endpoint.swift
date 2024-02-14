//
//  Endpoint.swift
//  DWTest
//
//  Created by Denis Windover on 14/02/2024.
//

import Foundation
import UIKit

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var body: [String: Any]? { get }
}
