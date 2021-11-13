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
    let items: [String]
}

struct PropertyResponse: Codable {
    let advertisementID, score: Int
    let agencyID, title, street, zip: String
    let text, city, country, geoLocation: String
    let offerType, objectCategory: String
    let objectType, numberRooms, floor, surfaceLiving: Int
    let surfaceUsable: Int
    let currency: String
    let sellingPrice, price: Int
    let priceUnit: String
    let timestamp: Int
    let timestampStr: String
    let balcony: Bool
    let lastModified, searchInquiryTimestamp: Int
    let picFilename1Small, picFilename1Medium: String
    let pictures: [String]
    let objectTypeLabel, countryLabel, floorLabel, propertyResponseDescription: String
    let listingType: String
    let agencyLogoURL: String
    let agencyPhoneDay, contactPerson, contactPhone: String
    let interestedFormType: Int
    let externalUrls: [ExternalURL]
    let picFilename1: String

    enum CodingKeys: String, CodingKey {
        case advertisementID = "advertisementId"
        case score
        case agencyID = "agencyId"
        case title, street, zip, text, city, country, geoLocation, offerType, objectCategory, objectType, numberRooms, floor, surfaceLiving, surfaceUsable, currency, sellingPrice, price, priceUnit, timestamp, timestampStr, balcony, lastModified, searchInquiryTimestamp, picFilename1Small, picFilename1Medium, pictures, objectTypeLabel, countryLabel, floorLabel
        case propertyResponseDescription = "description"
        case listingType
        case agencyLogoURL = "agencyLogoUrl"
        case agencyPhoneDay, contactPerson, contactPhone, interestedFormType, externalUrls, picFilename1
    }
}

struct ExternalURL: Codable {
    let url: String
    let type, label: String
}
