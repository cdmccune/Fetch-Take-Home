//
//  RecipeImageCache.swift
//  Fetch-Take-Home
//
//  Created by Curt McCune on 2/10/25.
//

import Foundation
import SwiftUI

final class RecipeImageCache {
    static let shared = RecipeImageCache()
    
    private var cache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        return cache
    }()
    
    private init() {}
    
    func image(for url: String) -> UIImage? {
        cache.object(forKey: url as NSString)
    }
    
    func insertImage(_ image: UIImage, for url: String) {
        cache.setObject(image, forKey: url as NSString)
    }
}

#if DEBUG
extension RecipeImageCache {
    static func preloadImages() {
        let exampleImage1 = UIImage(named: "exampleSmallPhoto1")!
        let exampleImage2 = UIImage(named: "exampleSmallPhoto2")!
        RecipeImageCache.shared.insertImage(exampleImage1, for: "preview_image_1")
        RecipeImageCache.shared.insertImage(exampleImage2, for: "preview_image_2")
    }
}
#endif
