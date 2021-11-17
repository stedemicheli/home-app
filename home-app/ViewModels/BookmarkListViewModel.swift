//
//  BookmarkListViewModel.swift
//  home-app
//
//  Created by Stefano on 17.11.21.
//

import Combine
import Foundation

final class BookmarkListViewModel: ObservableObject {
    
    enum State {
        case loading
        case error(message: String)
        case loaded(bookmarks: [BookmarkViewModel])
    }
    
    @Published var state: State = .loading
    
    private var properties: [Property] = []
    private let service: PersistentPropertyFetchable
    private let parser: AddressParseable
    private var cancellables = Set<AnyCancellable>()
    
    init(
        service: PersistentPropertyFetchable,
        parser: AddressParseable
    ) {
        self.service = service
        self.parser = parser
        fetchProperties()
    }
    
    func fetchProperties() {
        service.fetchPersistedProperties()
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
                let viewModels = properties.map(self.toBookmarkViewModel)
                self.state = .loaded(bookmarks: viewModels)
            }
            .store(in: &cancellables)
    }
    
    private func toBookmarkViewModel(_ model: Property) -> BookmarkViewModel {
        let address = parser.parse(
            street: model.street,
            zip: model.zip,
            text: model.text,
            city: model.city,
            country: model.country
        )
        return BookmarkViewModel(
            id: model.id,
            title: model.title,
            address: address,
            imageURL: model.imageURL.flatMap(URL.init)
        )
    }
}
