//
//  home_appApp.swift
//  home-app
//
//  Created by Stefano on 13.11.21.
//

import SwiftUI

@main
struct HomeApp: App {
    
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
        }
    }
}

enum HomeAppTabs {
    case properties
    case bookmarks
}
