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
 
    private let service: PropertyFetchable
    private let parser: AddressParseable & PriceParseable
    private var cancellables = Set<AnyCancellable>()
    
    init(
        service: PropertyFetchable,
        parser: AddressParseable & PriceParseable
    ) {
        self.service = service
        self.parser = parser
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
                let viewModels = properties.map(self.toPropertyViewModel)
                self.state = .loaded(properties: viewModels)
            }
            .store(in: &cancellables)
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
            sellingPrice: model.sellingPrice,
            price: model.price,
            priceUnit: model.priceUnit
        )
        return PropertyViewModel(
            title: model.title,
            address: address,
            price: price,
            imageURL: URL(string: model.imageURL)
        )
    }
}
