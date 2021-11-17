//
//  PropertyListView.swift
//  home-app
//
//  Created by Stefano on 13.11.21.
//

import SwiftUI

struct PropertyListView: View {
    
    @ObservedObject private var viewModel: PropertyListViewModel
    
    init(viewModel: PropertyListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            switch viewModel.state {
            case .loading:
                Text("Loading") // TODO: Localize
            case .error(message: let message):
                Text(message)
            case .loaded(properties: let properties):
                List {
                    ForEach(properties) { property in
                        PropertyView(
                            image: property.imageURL,
                            title: property.title,
                            address: property.address,
                            price: property.price,
                            onLike: {
                                viewModel.like(property: property)
                            }
                        )
                    }
                }
                .navigationTitle("Properties") // TODO: Localize
            }
        }
    }
}

struct PropertyListView_Previews: PreviewProvider {
    static var previews: some View {
        PropertyListView(viewModel: PropertyListViewModel(service: PropertyService(), parser: PropertyParser()))
    }
}
