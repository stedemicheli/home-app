//
//  PropertyServiceMock.swift
//  home-appTests
//
//  Created by Stefano on 17.11.21.
//

import Combine
@testable import home_app

final class PropertyServiceMock: PropertyServiceable, PersistentPropertyFetchable {
    
    var fetchPropertiesPublisher: AnyPublisher<[Property], Error> = Just([])
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    
    var fetchPersistedPropertiesPublisher: AnyPublisher<[Property], Error> = Just([])
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    
    var saveWasCalled: Bool = false
    var saveError: Error?
    
    func fetchProperties() -> AnyPublisher<[Property], Error> {
        fetchPropertiesPublisher
    }
    
    func save(property: Property) throws {
        saveWasCalled = true
        if let saveError = saveError { throw saveError }
    }
    
    func fetchPersistedProperties() -> AnyPublisher<[Property], Error> {
        fetchPropertiesPublisher
    }
}

enum PropertyErrorMock: Error {
    case mock
}
