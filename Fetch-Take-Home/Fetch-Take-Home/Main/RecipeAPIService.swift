//
//  RecipeAPIService.swift
//  Fetch-Take-Home
//
//  Created by Curt McCune on 2/10/25.
//

import Foundation

protocol RecipeAPIServiceProtocol {
    func getRecipes() async throws -> [Recipe]
}

struct RecipeAPIService: RecipeAPIServiceProtocol {
    
    init(urlType: URLType) {
        switch urlType {
        case .base:
            self.url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!
        case .malformed:
            self.url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json")!
        case .empty:
            self.url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json")!
        }
    }
    
    let url: URL
    
    func getRecipes() async throws -> [Recipe] {
        let request = URLRequest(url: url)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return try jsonDecoder.decode(RecipesResponse.self, from: data).recipes
    }
    
    enum URLType {
        case base, malformed, empty
    }
}

struct RecipeApiServicePreview: RecipeAPIServiceProtocol {
    
    var delay: TimeInterval = 0.0
    
    
    func getRecipes() async throws -> [Recipe] {
        try await Task.sleep(nanoseconds: 1_000_000 * UInt64(delay))
        
        return [
            Recipe(cuisine: "cuisine 1", 
                   name: "Recipe 1", 
                   photoUrlLarge: "preview_image_1", 
                   photoUrlSmall: "preview_image_1", 
                   uuid: "id1"),
            Recipe(cuisine: "cuisine 2", 
                   name: "Recipe 2", 
                   photoUrlLarge: "preview_image_2", 
                   photoUrlSmall: "preview_image_2", 
                   uuid: "id2")
        ]
    }
}
