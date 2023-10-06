//
//  UsageResponseModel.swift
//  XChange
//
//  Created by Aldo Vernando on 06/10/23.
//

/**
 This file defines several structures for decoding response data related to usage information from an exchange rate API. These structures conform to the `Decodable` protocol and are used for parsing JSON responses. This documentation provides an overview of each structure and its properties.
 */

import Foundation

/**
 A structure representing the response model for usage information.
 */
struct UsageResponseModel: Decodable {
    /// The status code associated with the response.
    var status: Int?
    
    /// The data related to usage information.
    var data: UsageDataResponseModel?
}

/**
 A structure representing the data related to usage information.
 */
struct UsageDataResponseModel: Decodable {
    /// The application ID associated with the usage data.
    var app_id: String?
    
    /// The status of the usage data.
    var status: String?
    
    /// The plan details related to usage data.
    var plan: UsagePlanResponseModel?
    
    /// The usage details related to usage data.
    var usage: UsageDetailResponseModel?
}

/**
 A structure representing the plan details related to usage data.
 */
struct UsagePlanResponseModel: Decodable {
    /// The name of the usage plan.
    var name: String?
    
    /// The quota associated with the usage plan.
    var quota: String?
    
    /// The update frequency of the usage plan.
    var update_frequency: String?
    
    /// The features available in the usage plan.
    var features: UsagePlanFeaturesResponseModel?
}

/**
 A structure representing the features available in a usage plan.
 */
struct UsagePlanFeaturesResponseModel: Decodable {
    /// Indicates whether the base feature is available.
    var base: Bool?
    
    /// Indicates whether the symbols feature is available.
    var symbols: Bool?
    
    /// Indicates whether the experimental feature is available.
    var experimental: Bool?
    
    /// Indicates whether the convert feature is available.
    var convert: Bool?
    
    /// Indicates whether the ohlc feature is available.
    var ohlc: Bool?
    
    /// Indicates whether the spot feature is available.
    var spot: Bool?
}

/**
 A structure representing the usage details related to usage data.
 */
struct UsageDetailResponseModel: Decodable {
    /// The total number of requests made.
    var requests: Int?
    
    /// The quota for the number of requests.
    var requests_quota: Int?
    
    /// The remaining number of requests allowed.
    var requests_remaining: Int?
    
    /// The number of days elapsed in the usage period.
    var days_elapsed: Int?
    
    /// The number of days remaining in the usage period.
    var days_remaining: Int?
    
    /// The daily average of requests made.
    var daily_average: Int?
}
