//
//  AddressParser.swift
//  home-app
//
//  Created by Stefano on 13.11.21.
//

protocol AddressParseable {
    func parse(
        street: String,
        zip: String,
        text: String,
        city: String,
        country: String
    ) -> String
}

protocol PriceParseable {
    func parse(
        currency: String,
        sellingPrice: Int,
        price: Int,
        priceUnit: String
    ) -> String
}

struct PropertyParser: AddressParseable, PriceParseable {
    
    func parse(
        street: String,
        zip: String,
        text: String,
        city: String,
        country: String
    ) -> String {
        street + " " + zip + " " + text + " " + city + " " + country // Just a simple parser for now
    }
    
    func parse(
        currency: String,
        sellingPrice: Int,
        price: Int,
        priceUnit: String
    ) -> String {
        String(price) + " " + currency // Just a simple parser for now
    }
}
