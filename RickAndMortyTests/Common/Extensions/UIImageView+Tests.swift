//
//  UIImageView+Tests.swift
//  RickAndMortyTests
//
//  Created by Vinícius Couto on 19/10/21.
//

import XCTest
@testable import RickAndMorty

class UIImageViewTests: XCTestCase {

    // MARK: - System under test

    let imageClientFake = RMImageClientFake()
    let sut = UIImageView()

    // MARK: - Test lifecycle

    override func tearDown() {
        super.tearDown()
        imageClientFake.clearCache()
    }

    // MARK: - Tests

    func testShouldDownloadAndSetImageWhenNotCached() {
        // Given
        let imageLink = Seeds.RMCharacters.rick.image
        let imageURL = URL(string: imageLink)!
        let completionExpectation = expectation(description: "Completion should be called")
        var imageFromCache: UIImage?

        // When
        sut.downloadRMImage(client: imageClientFake, from: imageLink) {
            completionExpectation.fulfill()
            imageFromCache = self.imageClientFake.getImage(forURL: imageURL)
        }

        // Then
        wait(for: [completionExpectation], timeout: 5)
        XCTAssertNotNil(imageFromCache)
    }

    func testShouldNotSetObjectWhenCached() {
        // Given
        let imageLink = Seeds.RMCharacters.rick.image
        let imageURL = URL(string: imageLink)!
        let completionExpectation = expectation(description: "Completion should be called")
        let imageStub = UIImage()
        var imageFromCache: UIImage?
        imageClientFake.imageCache.setObject(imageStub, forKey: imageLink as NSString)

        // When
        sut.downloadRMImage(client: imageClientFake, from: imageURL) {
            completionExpectation.fulfill()
            imageFromCache  = self.imageClientFake.getImage(forURL: imageURL)
        }

        // Then
        wait(for: [completionExpectation], timeout: 1)
        XCTAssertNotNil(imageFromCache)
        XCTAssertFalse(imageClientFake.setImageCalled)
    }
}

// MARK: - Test doubles

class RMImageClientFake: RMImageClientProtocol, RMImageCacheInjector {
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
