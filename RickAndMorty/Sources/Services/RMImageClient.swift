//
//  RMImageClient.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 18/10/21.
//

import UIKit

fileprivate let imageCache: NSCache<NSString, UIImage> = {
    let cache = NSCache<NSString, UIImage>()
    cache.countLimit = 1000

    return cache
}()

class RMImageClient {

    func getImage(forURL url: URL) -> UIImage? {
        imageCache.object(forKey: url.absoluteString as NSString)
    }

    func setImage(_ image: UIImage, forURL url: URL) {
        imageCache.setObject(image, forKey: url.absoluteString as NSString)
    }
}
