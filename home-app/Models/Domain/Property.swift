//
//  Property.swift
//  home-app
//
//  Created by Stefano on 13.11.21.
//

import Foundation

struct Property {
    let id: UUID = UUID()
    let title: String
    let street: String
    let zip: String
    let text: String
    let city: String
    let country: String
    let geoLocation: String
    let imageURL: String?
    let currency: String
    let sellingPrice: Int?
    let price: Int?
    let priceUnit: String
}

extension Property {
    
    init?(property: PersistedProperty) {
        guard let title = property.title,
              let street = property.street,
              let zip = property.zip,
              let text = property.text,
              let city = property.city,
              let country = property.country,
              let geoLocation = property.geoLocation,
              let imageURL = property.imageURL,
              let currency = property.currency,
              let priceUnit = property.priceUnit
        else {
            return nil
        }
        
        self.init(
            title: title,
            street: street,
            zip: zip,
            text: text,
            city: city,
            country: country,
            geoLocation: geoLocation,
            imageURL: imageURL,
            currency: currency,
            sellingPrice: Int(property.sellingPrice),
            price: Int(property.price),
            priceUnit: priceUnit
        )
    }
}
