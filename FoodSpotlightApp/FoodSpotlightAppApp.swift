//
//  FoodSpotlightAppApp.swift
//  FoodSpotlightApp
//
//  Created by Omar on 19.11.2021.
//

import SwiftUI

@main
struct FoodSpotlightAppApp: App {
    let viewModel = HomeViewModel()
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(viewModel)
                .environment(\.managedObjectContext, viewModel.container.viewContext)
        }
    }
}
