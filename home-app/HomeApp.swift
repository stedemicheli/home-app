//
//  home_appApp.swift
//  home-app
//
//  Created by Stefano on 13.11.21.
//

import SwiftUI

@main
struct HomeApp: App {
    
//    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            TabView {
                PropertyListView(viewModel: PropertyListViewModel(service: PropertyService(), parser: PropertyParser()))
                    .tabItem { Label("Properties", systemImage: "house") }
                    .tag(HomeAppTabs.properties)
                BookmarkListView(viewModel: BookmarkListViewModel(service: PropertyService(), parser: PropertyParser()))
                    .tabItem { Label("Bookmarks", systemImage: "bookmark") }
                    .tag(HomeAppTabs.bookmarks)
            }
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

enum HomeAppTabs {
    case properties
    case bookmarks
}
