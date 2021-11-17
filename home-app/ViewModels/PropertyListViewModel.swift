//
//  PropertyListViewModel.swift
//  home-app
//
//  Created by Stefano on 13.11.21.
//

import Combine
import Foundation

final class PropertyListViewModel: ObservableObject {
    
    enum State {
        case loading
        case error(message: String)
        case loaded(properties: [PropertyViewModel])
    }
    
    @Published var state: State = .loading
    
    private var properties: [Property] = []
    private let service: PropertyServiceable
    private let parser: AddressParseable & PriceParseable
    private var cancellables = Set<AnyCancellable>()
    
    init(
        service: PropertyServiceable,
        parser: AddressParseable & PriceParseable
    ) {
        self.service = service
        self.parser = parser
        fetchProperties()
    }
    
    func fetchProperties() {
        service.fetchProperties()
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure:
                    self?.state = .error(
                        message: "Something went wrong. Please try again later." // TODO: Localize
                    )
                }
            } receiveValue: { [weak self] properties in
                guard let self = self else { return }
                self.properties = properties
                let viewModels = properties.map(self.toPropertyViewModel)
                self.state = .loaded(properties: viewModels)
            }
            .store(in: &cancellables)
    }
    
    func like(property: PropertyViewModel) {
        guard let property = properties.first(where: { $0.id == property.id }) else { return }
        do {
            try service.save(property: property)
        } catch {
            state = .error(
                message: "Something went wrong. Please try again later." // TODO: Localize
            )
        }
    }
    
    private func toPropertyViewModel(_ model: Property) -> PropertyViewModel {
        let address = parser.parse(
            street: model.street,
            zip: model.zip,
            text: model.text,
            city: model.city,
            country: model.country
        )
        let price = parser.parse(
            currency: model.currency,
            sellingPrice: model.sellingPrice ?? 0,
            price: model.price ?? 0,
            priceUnit: model.priceUnit
        )
        return PropertyViewModel(
            id: model.id,
            title: model.title,
            address: address,
            price: price,
            imageURL: model.imageURL.flatMap(URL.init)
        )
    }
}
