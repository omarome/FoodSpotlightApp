//
//  FoodSpotlightAppApp.swift
//  FoodSpotlightApp
//
//  Created by Omar on 19.11.2021.
//

import SwiftUI

@main
struct FoodSpotlightAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
