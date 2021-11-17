//
//  BookmarkListView.swift
//  home-app
//
//  Created by Stefano on 16.11.21.
//

import SwiftUI

struct BookmarkListView: View {
    
    @ObservedObject private var viewModel: BookmarkListViewModel
    
    init(viewModel: BookmarkListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            switch viewModel.state {
            case .loading:
                Text("Loading")
            case .error(message: let message):
                Text(message)
            case .loaded(bookmarks: let bookmarks):
                List {
                    ForEach(bookmarks) { bookmark in
                        BookmarkView(
                            image: bookmark.imageURL,
                            title: bookmark.title,
                            address: bookmark.address
                        )
                    }
                }
                .navigationTitle("Bookmarks") // TODO: Localize
                .onAppear {
                    viewModel.fetchProperties()
                }
            }
        }
    }
}

struct BookmarkListView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarkListView(viewModel: BookmarkListViewModel(service: PropertyService(), parser: PropertyParser()))
    }
}
