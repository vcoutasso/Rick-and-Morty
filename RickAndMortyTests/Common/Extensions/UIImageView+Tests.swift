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

    let imageClientFake = RMImageServiceFake()
    let sut = UIImageView()

    // MARK: - Test lifecycle

    override func tearDown() {
        super.tearDown()
        imageClientFake.clearCache()
    }

    // MARK: - Tests

    func testShouldDownloadAndSetImageWhenNotCached() {
        // Given
        let imageLink = Fixtures.RMCharacters.rick.image
        let imageURL = URL(string: imageLink)!
        let completionExpectation = expectation(description: "Completion should be called")
        var imageFromCache: UIImage?

        // When
        sut.downloadRMImage(service: imageClientFake, from: imageLink) {
            completionExpectation.fulfill()
            imageFromCache = self.imageClientFake.getImage(forURL: imageURL)
        }

        // Then
        wait(for: [completionExpectation], timeout: 5)
        XCTAssertNotNil(imageFromCache)
    }

    func testShouldNotSetObjectWhenCached() {
        // Given
        let imageLink = Fixtures.RMCharacters.rick.image
        let imageURL = URL(string: imageLink)!
        let completionExpectation = expectation(description: "Completion should be called")
        let imageStub = UIImage()
        var imageFromCache: UIImage?
        imageClientFake.imageCache.setObject(imageStub, forKey: imageLink as NSString)

        // When
        sut.downloadRMImage(service: imageClientFake, from: imageURL) {
            completionExpectation.fulfill()
            imageFromCache  = self.imageClientFake.getImage(forURL: imageURL)
        }

        // Then
        wait(for: [completionExpectation], timeout: 1)
        XCTAssertNotNil(imageFromCache)
        XCTAssertFalse(imageClientFake.setImageCalled)
    }
}
