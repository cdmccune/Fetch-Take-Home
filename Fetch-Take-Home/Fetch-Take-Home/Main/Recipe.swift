//
//  Recipe.swift
//  Fetch-Take-Home
//
//  Created by Curt McCune on 2/10/25.
//

import Foundation

struct Recipe: Codable, Identifiable {
    var cuisine: String
    var name: String
    var photoUrlLarge: String
    var photoUrlSmall: String
    var uuid: String
    var sourceUrl: String?
    var youtubeUrl: String?
    
    var id: String { return uuid }
}

struct RecipesResponse: Codable {
    var recipes: [Recipe]
}
