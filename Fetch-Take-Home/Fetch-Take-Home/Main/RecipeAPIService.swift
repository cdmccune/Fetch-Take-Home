//
//  RecipeAPIService.swift
//  Fetch-Take-Home
//
//  Created by Curt McCune on 2/10/25.
//

import Foundation

struct RecipeAPIService {
    
    let url: URL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!
    let malformedUrl: URL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json")!
    let emptyUrl: URL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json")!
    
    func getRecipes() async throws -> [Recipe] {
        let request = URLRequest(url: url)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return try jsonDecoder.decode([Recipe].self, from: data)
    }
}
