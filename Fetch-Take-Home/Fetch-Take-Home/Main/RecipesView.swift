//
//  RecipesView.swift
//  Fetch-Take-Home
//
//  Created by Curt McCune on 2/10/25.
//

import SwiftUI

struct RecipesView: View {
    
    @ObservedObject var viewModel: RecipesViewModel = RecipesViewModel()
    
    var body: some View {
        VStack {
            ForEach(viewModel.recipes) { recipe in
                Text(recipe.name)
            }
        }
        .padding()
        .onAppear() {
            viewModel.recipes = [
                Recipe(cuisine: "", name: "hello", photoURLLarge: "", photoURLSmall: "", uuid: "d"),
                Recipe(cuisine: "", name: "helloa", photoURLLarge: "", photoURLSmall: "", uuid: "s")
            ]
        }
    }
}

#Preview {
    RecipesView()
}
