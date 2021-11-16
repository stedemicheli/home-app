//
//  PropertyService.swift
//  home-app
//
//  Created by Stefano on 13.11.21.
//

import Combine
import Foundation

protocol PropertyFetchable {
    func fetchProperties() -> AnyPublisher<[Property], Error>
}

protocol PropertyPersisteable {
    func save(property: Property) throws
}

typealias PropertyServiceable = PropertyFetchable & PropertyPersisteable

final class PropertyService: PropertyServiceable {
    
    private let networkClient: NetworkClient
    private let persistenceStore: PersistenceStoreProtocol
    
    init(networkClient: NetworkClient = NetworkClientImpl(),
         persistenceStore: PersistenceStoreProtocol = PersistenceStore.shared) {
        self.networkClient = networkClient
        self.persistenceStore = persistenceStore
    }
    
    func fetchProperties() -> AnyPublisher<[Property], Error> {
        let components = buildPropertiesURLComponents()
        return networkClient
            .request(with: components)
            .map(toProperties)
            .mapError { $0 }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func save(property: Property) throws {
        let _ = PersistedProperty(property: property)
        try persistenceStore.save(context: nil)
    }
    
    private func buildPropertiesURLComponents() -> URLComponents {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "private-492e5-homegate1.apiary-mock.com"
        components.path = "/properties"
        return components
    }
    
    private func toProperties(_ response: PropertyListResponse) -> [Property] {
        response.items.map(Property.init)
    }
}

extension Property {
    
    init(_ response: PropertyResponse) {
        self.title = response.title
        self.street = response.street
        self.zip = response.zip
        self.text = response.text
        self.city = response.city
        self.country = response.country
        self.geoLocation = response.geoLocation
        self.imageURL = response.picFilename1.replacingOccurrences(of: "uat.", with: "")
        self.currency = response.currency
        self.sellingPrice = response.sellingPrice
        self.price = response.price
        self.priceUnit = response.priceUnit
    }
}
