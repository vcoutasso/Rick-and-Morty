//
//  RMImageServiceFake.swift
//  RickAndMortyTests
//
//  Created by Vinícius Couto on 21/10/21.
//

import XCTest
@testable import RickAndMorty

final class RMImageServiceFake: RMImageServiceProtocol, RMImageCacheInjector {
    static var cacheCountLimit = 1

    func getImage(forURL url: URL) -> UIImage? {
        imageCache.object(forKey: url.absoluteString as NSString)
    }

    private(set) var setImageCalled = false
    func setImage(_ image: UIImage, forURL url: URL) {
        setImageCalled = true
        imageCache.setObject(image, forKey: url.absoluteString as NSString)
    }

    func clearCache() {
        imageCache.removeAllObjects()
    }
}
