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

protocol PersistentPropertyFetchable {
    func fetchPersistedProperties() -> AnyPublisher<[Property], Error>
}

protocol PropertyPersisteable {
    func save(property: Property) throws
}

typealias PropertyServiceable = PropertyFetchable & PropertyPersisteable

final class PropertyService: PropertyServiceable, PersistentPropertyFetchable {
    
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
    
    func fetchPersistedProperties() -> AnyPublisher<[Property], Error> {
        do {
            let persistedProperties: [PersistedProperty] = try persistenceStore.fetch(recent: 100, in: nil)
            let properties = persistedProperties.compactMap(Property.init)
            return Just(properties)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch let error {
            return Fail(error: error).eraseToAnyPublisher()
        }
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
