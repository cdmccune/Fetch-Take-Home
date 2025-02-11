//
//  RecipeCardView.swift
//  Fetch-Take-Home
//
//  Created by Curt McCune on 2/11/25.
//

import SwiftUI

struct RecipeCardView: View {
    
    var recipe: Recipe
    
    var body: some View {
        HStack(spacing: 10) {
            CachedImageView(url: recipe.photoUrlLarge)
                .frame(height: 75)
                .aspectRatio(contentMode: .fill)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            VStack(alignment: .leading, spacing: 0) {
                Text(recipe.name)
                    .font(.title3)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                
                Text(recipe.cuisine)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Spacer()
            }
            
            Spacer()
            
        }
        .frame(height: 75)
    }
}

#Preview {
    RecipeImageCache.preloadImages()
    return RecipeCardView(recipe:  Recipe(cuisine: "cuisine 2",
                                          name: "Recipe 2",
                                          photoUrlLarge: "preview_image_2",
                                          photoUrlSmall: "preview_image_2",
                                          uuid: "id2"))
}
