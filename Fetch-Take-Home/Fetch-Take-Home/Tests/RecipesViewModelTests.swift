//
//  RecipesViewModelTests.swift
//  Fetch-Take-Home
//
//  Created by Curt McCune on 2/11/25.
//

import XCTest
@testable import Fetch_Take_Home

final class RecipesViewModelTests: XCTestCase {
    
    
    //MARK: - Initialization

    func test_RecipesViewModel_WhenIntialized_ShouldSetRecipeApiService() {
        // given
        // when
        let recipeApiService = MockRecipeApiService()
        let sut = RecipesViewModel(apiService: recipeApiService)
        
        // then
        XCTAssertIdentical(recipeApiService, sut.apiService as? MockRecipeApiService)
    }
    
    
    // MARK: - Load Recipes
    
    func test_RecipesViewModel_WhenLoadRecipesCalled_ShouldSetIsLoadingToTrue() async {
        // given
        let recipeApiService = MockRecipeApiService()
        recipeApiService.delay = 0.2
        let sut = RecipesViewModel(apiService: recipeApiService)
        sut.isLoading = false
        
        // when
        sut.loadRecipes()
        
        try? await Task.sleep(for: .seconds(0.1))
        
        // then
        XCTAssertTrue(sut.isLoading)
    }
    
    func test_RecipesViewModel_WhenLoadRecipesCalled_ShouldCallApiServiceGetRecipes() async {
        // given
        let recipeApiService = MockRecipeApiService()
        let sut = RecipesViewModel(apiService: recipeApiService)
        
        // when
        sut.loadRecipes()
        
        try? await Task.sleep(for: .seconds(0.1))
        
        // then
        XCTAssertEqual(recipeApiService.getRecipeCallCount, 1)
    }
    
    func test_RecipesViewModel_WhenLoadRecipesCalledAndRecipesReturns_ShouldSetOwnRecipesToValue() async {
        // given
        let recipeID = UUID().uuidString
        let count = Int.random(in: 3...10)
        
        let recipes = Array(repeating: Recipe(cuisine: "", name: "", photoUrlLarge: "", photoUrlSmall: "", uuid: recipeID), count: count)
        let apiService = MockRecipeApiService()
        apiService.recipesToReturn = recipes
        let sut = RecipesViewModel(apiService: apiService)
        
        // when
        sut.loadRecipes()
        
        try? await Task.sleep(for: .seconds(0.1))
        
        // then
        XCTAssertEqual(recipeID, sut.recipes.first?.id)
        XCTAssertEqual(count, sut.recipes.count)
    }
    
    func test_RecipesViewModel_WhenLoadRecipesCalledErrorReturned_ShouldSetErrorMessage() async {
        // given
        let apiService = MockRecipeApiService()
        apiService.errorToThrow = NSError(domain: "", code: 0)
        let sut = RecipesViewModel(apiService: apiService)
        
        // when
        sut.loadRecipes()
        
        try? await Task.sleep(for: .seconds(0.1))
        
        // then
        XCTAssertEqual(sut.errorMessage, "There was an error decoding the data.")
    }
    
    func test_RecipesViewModel_WhenLoadRecipesCalledErrorReturned_ShouldSetRecipesToEmpty() async {
        // given
        let apiService = MockRecipeApiService()
        apiService.errorToThrow = NSError(domain: "", code: 0)
        let sut = RecipesViewModel(apiService: apiService)
        sut.recipes = [Recipe(cuisine: "", name: "", photoUrlLarge: "", photoUrlSmall: "", uuid: "")]
        
        // when
        sut.loadRecipes()
        
        try? await Task.sleep(for: .seconds(0.1))
        
        // then
        XCTAssertTrue(sut.recipes.isEmpty)
    }
    
    func test_RecipesViewModel_WhenLoadRecipesCalledApiServiceReturned_ShouldSetIsLoadingToFalse() async {
        // given
        let apiService = MockRecipeApiService()
        let sut = RecipesViewModel(apiService: apiService)
        sut.isLoading = true
        
        // when
        sut.loadRecipes()
        
        try? await Task.sleep(for: .seconds(0.1))
        
        // then
        XCTAssertFalse(sut.isLoading)
    }
    

    

}

class MockRecipeApiService: RecipeAPIServiceProtocol {
    var getRecipeCallCount = 0
    var delay: TimeInterval = 0
    var recipesToReturn: [Recipe] = []
    var errorToThrow: Error?
    
    func getRecipes() async throws -> [Recipe] {
        
        guard errorToThrow == nil else {
            throw errorToThrow ?? NSError(domain: "", code: 0)
        }
        
        getRecipeCallCount += 1
        try await Task.sleep(for: .seconds(delay))
        return recipesToReturn
    }
}
