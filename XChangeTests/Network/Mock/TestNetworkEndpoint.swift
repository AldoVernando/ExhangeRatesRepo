//
//  TestNetworkEndpoint.swift
//  XChangeTests
//
//  Created by Aldo Vernando on 08/10/23.
//

import Foundation

@testable import XChange

// Test Response Model
struct TestResponseModel: Decodable {
    let message: String
}

// Test Network Endpoint
enum TestNetworkEndpoint: NetworkEndpoint {
    case dashboard
    case submitData
    
    var baseUrl: String {
        return "https://example.com"
    }
    
    var endpoint: String {
        switch self {
        case .dashboard:
            return "/dashboard"
        case .submitData:
            return "/submit/data"
        }
    }
    
    var httpMethod: String {
        switch self {
        case .submitData:
            return "POST"
        default:
            return "GET"
        }
    }
    
    var headers: [String: String] {
        return ["Content-Type": "application/json"]
    }
    
    var bodyParams: [String: Any]? {
        switch self {
        case .submitData:
            return [
                "id": 123
            ]
        default:
            return nil
        }
    }
}
