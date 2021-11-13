//
//  PropertyService.swift
//  home-app
//
//  Created by Stefano on 13.11.21.
//

import Combine

protocol PropertyFetchable {
    func fetchProperties() -> AnyPublisher<[Property], Error>
}
