//
//  RecipesView.swift
//  Fetch-Take-Home
//
//  Created by Curt McCune on 2/10/25.
//

import SwiftUI

struct RecipesView: View {
    
    @ObservedObject var viewModel: RecipesViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.recipes) { recipe in
                    VStack {
                        CachedImageView(url: recipe.photoUrlLarge)
                            .frame(height: 200)
                        Text(recipe.name)
                            .font(.headline)
                    }
                }
            }
            .padding()
        }
        .onAppear() {
            viewModel.loadRecipes()
        }
    }
}

#Preview {
    RecipeImageCache.preloadImages()
    return RecipesView(viewModel: RecipesViewModel(apiService: RecipeApiServicePreview()))
}
