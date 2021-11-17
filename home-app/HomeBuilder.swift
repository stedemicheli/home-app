//
//  HomeBuilder.swift
//  home-app
//
//  Created by Stefano on 17.11.21.
//

import SwiftUI

struct HomeBuilder {
    
    static func buildPropertyList() -> some View {
        PropertyListView(
            viewModel: PropertyListViewModel(
                service: PropertyService(),
                parser: PropertyParser()
            )
        )
    }
    
    static func buildBookmarkList() -> some View {
        BookmarkListView(
            viewModel: BookmarkListViewModel(
                service: PropertyService(),
                parser: PropertyParser()
            )
        )
    }
}
