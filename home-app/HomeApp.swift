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
                HomeBuilder.buildPropertyList()
                    .tabItem { Label("Properties", systemImage: "house") }
                    .tag(HomeAppTabs.properties)
                HomeBuilder.buildBookmarkList()
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
