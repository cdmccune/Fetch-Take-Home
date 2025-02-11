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
        
        NavigationStack {
            ScrollView {
                
                LazyVStack(spacing: 15) {
                    
                    if viewModel.isLoading {
                        HStack {
                            Text("Loading")
                            ProgressView()
                        }
                        
                    } else if let error = viewModel.errorMessage {
                        Text(error)
                        
                    } else if viewModel.recipes.isEmpty {
                        Text("There are no recipes available")
                        
                    } else {
                        ForEach(viewModel.recipes) { recipe in
                            RecipeCardView(recipe: recipe)
                        }
                        
                    }
                    
                }
                .padding()
            }
            .onAppear() {
                viewModel.loadRecipes()
            }
            .refreshable {
                viewModel.loadRecipes()
            }
            .navigationTitle("Recipes")
        }
    }
}

#Preview {
    RecipeImageCache.preloadImages()
    var viewModel = RecipesViewModel(apiService: RecipeApiServicePreview(delay: 3000))
    return RecipesView(viewModel: viewModel)
}
