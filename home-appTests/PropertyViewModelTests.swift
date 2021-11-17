//
//  PropertyViewModelTests.swift
//  home-appTests
//
//  Created by Stefano on 17.11.21.
//

import Combine
import XCTest
@testable import home_app

class PropertyViewModelTests: XCTestCase {

    var sut: PropertyListViewModel!
    var service: PropertyServiceMock!
    
    override func setUp() {
        super.setUp()
        service = PropertyServiceMock()
        sut = PropertyListViewModel(
            service: service,
            parser: PropertyParser()
        )
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testPropertiesWereFetched() {
        // given
        service.fetchPropertiesPublisher = Just([.mock])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        
        // when
        sut.fetchProperties()
        
        // then
        guard case .loaded(properties: let properties) = sut.state else { return XCTFail() }
        XCTAssertEqual(properties.count, 1)
        XCTAssertEqual(properties.first?.id, "id")
    }
    
    func testFetchPropertiesThrowsError() {
        // given
        service.fetchPropertiesPublisher = Fail(error: PropertyErrorMock.mock)
            .eraseToAnyPublisher()
        
        // when
        sut.fetchProperties()
        
        // then
        guard case .error = sut.state else { return XCTFail() }
    }
    
    func testLikePropertySucceeds() {
        // given
        service.fetchPropertiesPublisher = Just([.mock])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        service.saveError = nil
        
        // when
        sut.fetchProperties()
        sut.like(property: .mock)
        
        // then
        XCTAssertTrue(service.saveWasCalled)
        guard case .loaded = sut.state else { return XCTFail() }
    }
    
    func testLikePropertyThrowsError() {
        // given
        service.fetchPropertiesPublisher = Just([.mock])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        service.saveError = PropertyErrorMock.mock
        
        // when
        sut.fetchProperties()
        sut.like(property: .mock)
        
        // then
        XCTAssertTrue(service.saveWasCalled)
        guard case .error = sut.state else { return XCTFail() }
    }
}

private extension Property {
    
    static var mock: Property {
        .init(
            id: "id",
            title: "title",
            street: "street",
            zip: "zip",
            text: "text",
            city: "city",
            country: "country",
            geoLocation: "geoLocation",
            imageURL: "imageURL",
            currency: "currency",
            sellingPrice: 100,
            price: 100,
            priceUnit: "priceUnit"
        )
    }
}


private extension PropertyViewModel {
    
    static var mock: PropertyViewModel {
        .init(
            id: "id",
            title: "title",
            address: "address",
            price: "price",
            imageURL: URL(string: "www.google.com")
        )
    }
}
