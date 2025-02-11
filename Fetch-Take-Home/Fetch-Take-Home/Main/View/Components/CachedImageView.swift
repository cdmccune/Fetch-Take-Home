//
//  CachedImageView.swift
//  Fetch-Take-Home
//
//  Created by Curt McCune on 2/10/25.
//

import SwiftUI

struct CachedImageView: View {
    let url: String
        @State private var image: UIImage?
        
        var body: some View {
            Group {
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } else {
                    ProgressView()
                        .task {
                            await loadImage()
                        }
                }
            }
        }
        
        private func loadImage() async {
            if let cached = RecipeImageCache.shared.image(for: url) {
                self.image = cached
                return
            }
            
            guard let imageUrl = URL(string: url),
                  let (data, _) = try? await URLSession.shared.data(from: imageUrl),
                  let downloadedImage = UIImage(data: data) else {
                return
            }
            
            RecipeImageCache.shared.insertImage(downloadedImage, for: url)
            self.image = downloadedImage
        }
}
