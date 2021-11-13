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

final class PropertyService: PropertyFetchable {
    
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient = NetworkClientImpl()) {
        self.networkClient = networkClient
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
    
    private func buildPropertiesURLComponents() -> URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "http://private-492e5-homegate1.apiary-mock.com"
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
        self.imageURL = response.pictures.first
        self.currency = response.currency
        self.sellingPrice = response.sellingPrice
        self.price = response.price
        self.priceUnit = response.priceUnit
    }
}
