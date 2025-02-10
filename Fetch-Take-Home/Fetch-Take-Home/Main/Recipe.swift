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
    var photoURLLarge: String
    var photoURLSmall: String
    var uuid: String
    var sourceURL: String?
    var youtubeURL: String?
    
    var id: String { return uuid }
}
