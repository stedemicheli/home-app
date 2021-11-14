//
//  PropertyResponse.swift
//  home-app
//
//  Created by Stefano on 13.11.21.
//

import Foundation

struct PropertyListResponse: Codable {
    let resultCount, start, page, pageCount: Int
    let itemsPerPage: Int
    let hasNextPage, hasPreviousPage: Bool
    let items: [PropertyResponse]
}

struct PropertyResponse: Codable {
    let advertisementId: Int
    let title: String
    let street: String
    let zip: String
    let text: String
    let city: String
    let geoLocation: String
    let country: String
    let currency: String
    let sellingPrice: Int?
    let price: Int?
    let priceUnit: String
    let timestamp: Int
    let timestampStr: String
    let pictures: [String]
    let picFilename1: String
}
