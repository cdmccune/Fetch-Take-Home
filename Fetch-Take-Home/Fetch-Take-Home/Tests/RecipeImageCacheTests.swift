//
//  RecipeImageCacheTests.swift
//  Fetch-Take-HomeTests
//
//  Created by Curt McCune on 2/11/25.
//

import XCTest
@testable import Fetch_Take_Home

final class RecipeImageCacheTests: XCTestCase {

    func test_RecipeImageCache_WhenInsertImageCalled_ShouldAddTheImageToTheCache() {
        // given
        let sut = RecipeImageCache()
        let uiImage = UIImage()
        let string = UUID().uuidString
        
        // when
        sut.insertImage(uiImage, for: string)
        
        // then
        let resultImage: UIImage? = sut.cache.object(forKey: string as NSString)
        XCTAssertEqual(resultImage, uiImage)
    }
    
    func test_RecipeImageCache_WhenImageForCalledImageExists_ShouldReturnImage() {
        // given
        let sut = RecipeImageCache()
        let uiImage = UIImage()
        let string = UUID().uuidString
        
        sut.cache.setObject(uiImage, forKey: string as NSString)
        
        // when
        let image = sut.image(for: string)
        
        // then
        XCTAssertEqual(image, uiImage)
    }
    
    func test_RecipeImageCache_WhenImageForCalledImageDoesNotExist_ShouldReturnNil() {
        // given
        let sut = RecipeImageCache()
        
        // when
        let image = sut.image(for: "string")
        
        // then
        XCTAssertNil(image)
    }

}
