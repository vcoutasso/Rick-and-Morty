//
//  RMImageServiceTests.swift
//  RickAndMortyTests
//
//  Created by Vinícius Couto on 19/10/21.
//

import XCTest
@testable import RickAndMorty

class RMImageServiceTests: XCTestCase {

    // MARK: - System under test

    private let sut = RMImageService()

    // MARK: - Test lifecycle

    override func tearDown() {
        super.tearDown()
        sut.imageCache.removeAllObjects()
    }

    // MARK: - Tests

    func testShouldSetCacheCountLimit() {
        // Given / When
        let countLimit = sut.imageCache.countLimit

        // Then
        XCTAssertGreaterThan(countLimit, 0)
    }

    func testGetImageShouldReturnNilWhenImageNotCached() {
        // Given
        let dummyImageLink = Fixtures.RMCharacters.morty.image
        let url = URL(string: dummyImageLink)!

        // When
        let image = sut.getImage(forURL: url)

        // Then
        XCTAssertNil(image)
    }

    func testGetImageShouldReturnImageWhenCached() {
        // Given
        let dummyCharacter = Fixtures.RMCharacters.morty
        let dummyImageLink = dummyCharacter.image
        let dummyImage = UIImage()
        let url = URL(string: dummyImageLink)!
        sut.setImage(dummyImage, forURL: url)

        // When
        let image = sut.getImage(forURL: url)

        // Then
        XCTAssertNotNil(image)
    }
}
