//
//  RecipesViewModel.swift
//  Fetch-Take-Home
//
//  Created by Curt McCune on 2/10/25.
//

import Foundation

class RecipesViewModel: ObservableObject {
    
    init(apiService: RecipeAPIServiceProtocol = RecipeAPIService(urlType: .base)) {
        self.apiService = apiService
    }
    
    @Published var recipes: [Recipe] = []
    
    var apiService: RecipeAPIServiceProtocol
    
    func loadRecipes() {
        Task {
            do {
                let recipes = try await apiService.getRecipes()
                
                await MainActor.run {
                    self.recipes = recipes
                }
                
            } catch {
                print("hit error", error)
            }
        }
    }
}
