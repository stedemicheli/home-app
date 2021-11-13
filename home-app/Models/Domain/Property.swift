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
    let imageURL: String
    let currency: String
    let sellingPrice: Int
    let price: Int
    let priceUnit: String
}
