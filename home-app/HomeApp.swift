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
            PropertyListView(viewModel: PropertyListViewModel(service: PropertyService(), parser: PropertyParser()))
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
