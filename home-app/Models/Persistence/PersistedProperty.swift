//
//  PersistedProperty.swift
//  home-app
//
//  Created by Stefano on 15.11.21.
//

import CoreData

extension PersistedProperty {
    
    convenience init(
        id: String,
        title: String,
        street: String,
        zip: String,
        text: String,
        city: String,
        country: String,
        geoLocation: String,
        imageURL: String?,
        currency: String,
        sellingPrice: Int?,
        price: Int?,
        priceUnit: String,
        context: NSManagedObjectContext = PersistenceStore.shared.mainContext
    ) {
        self.init(context: context)
        self.id = id
        self.title = title
        self.street = street
        self.zip = zip
        self.text = text
        self.city = city
        self.country = country
        self.geoLocation = geoLocation
        self.imageURL = imageURL
        self.currency = currency
        self.sellingPrice = Int64(sellingPrice ?? 0)
        self.price = Int64(price ?? 0)
        self.priceUnit = priceUnit
    }
    
    convenience init(property: Property) {
        self.init(
            id: property.id,
            title: property.title,
            street: property.street,
            zip: property.zip,
            text: property.text,
            city: property.city,
            country: property.country,
            geoLocation: property.geoLocation,
            imageURL: property.imageURL,
            currency: property.currency,
            sellingPrice: property.sellingPrice,
            price: property.price,
            priceUnit: property.priceUnit
        )
    }
}
