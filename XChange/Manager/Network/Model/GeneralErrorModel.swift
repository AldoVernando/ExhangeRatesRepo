//
//  GeneralErrorModel.swift
//  XChange
//
//  Created by Aldo Vernando on 04/10/23.
//

/**
 GeneralErrorModel.swift
 
 This file defines the `GeneralErrorModel` structure and the `GeneralErrorModelProtocol` protocol, which are used to represent and decode general error responses from the server. This documentation provides an overview of their purpose and usage.
 */

import Foundation

/**
 A protocol that defines the structure of a general error model for decoding error responses from the server.
 */
protocol GeneralErrorModelProtocol: Decodable {
    var error: Bool? { get }
    var status: Int? { get }
    var message: String? { get }
    var description: String? { get }
}

/**
 A structure representing a general error model that conforms to the `GeneralErrorModelProtocol`.
 */
struct GeneralErrorModel: GeneralErrorModelProtocol {
    var error: Bool?
    var status: Int?
    var message: String?
    var description: String?
}
