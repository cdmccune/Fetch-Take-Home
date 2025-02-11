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
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    var apiService: RecipeAPIServiceProtocol
    
    func loadRecipes() {
        Task {
            await MainActor.run {
                isLoading = true
            }
            
            do {
                let recipes = try await apiService.getRecipes()
                
                await MainActor.run {
                    self.recipes = recipes
                }
                
            } catch {
                print("Error transforming data", error)
                await MainActor.run {
                    self.errorMessage = "There was an error decoding the data."
                    self.recipes = []
                }
            }
            
            await MainActor.run {
                isLoading = false
            }
        }
    }
}
