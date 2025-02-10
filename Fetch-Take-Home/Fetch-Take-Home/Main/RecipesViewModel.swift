//
//  RecipesViewModel.swift
//  Fetch-Take-Home
//
//  Created by Curt McCune on 2/10/25.
//

import Foundation

class RecipesViewModel: ObservableObject {
    
    @Published var recipes: [Recipe] = []
    
    lazy var apiService = RecipeAPIService()
    
    func loadRecipes() {
        Task {
            do {
                let recipes = try await apiService.getRecipes()
                
                await MainActor.run {
                    self.recipes = recipes
                }
                
            } catch {
                
            }
        }
    }
}
