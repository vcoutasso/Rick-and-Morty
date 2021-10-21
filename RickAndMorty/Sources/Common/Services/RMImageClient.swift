//
//  RMImageClient.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 18/10/21.
//

import UIKit

fileprivate let sharedImageCache: NSCache<NSString, UIImage> = .init()

protocol RMImageCacheInjector {
    var imageCache: NSCache<NSString, UIImage> { get }
}

extension RMImageCacheInjector {
    var imageCache: NSCache<NSString, UIImage> {
        sharedImageCache
    }
}

protocol RMImageClientProtocol {
    static var cacheCountLimit: Int { get }

    func getImage(forURL url: URL) -> UIImage?
    func setImage(_ image: UIImage, forURL url: URL)
}

class RMImageClient: RMImageClientProtocol, RMImageCacheInjector {
    static var cacheCountLimit = 1000

    init() {
        imageCache.countLimit = Self.cacheCountLimit
    }

    func getImage(forURL url: URL) -> UIImage? {
        imageCache.object(forKey: url.absoluteString as NSString)
    }

    func setImage(_ image: UIImage, forURL url: URL) {
        imageCache.setObject(image, forKey: url.absoluteString as NSString)
    }
}
