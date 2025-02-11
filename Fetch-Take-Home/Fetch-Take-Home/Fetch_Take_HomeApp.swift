//
//  Fetch_Take_HomeApp.swift
//  Fetch-Take-Home
//
//  Created by Curt McCune on 2/10/25.
//

import SwiftUI

@main
struct Fetch_Take_HomeApp: App {
    var body: some Scene {
        WindowGroup {
            RecipesView(viewModel: RecipesViewModel(apiService: RecipeAPIService(urlType: .base)))
        }
    }
}
