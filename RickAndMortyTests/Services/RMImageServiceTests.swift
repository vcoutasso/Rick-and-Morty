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

    // MARK: - Tests

    func testShouldSetCacheCountLimit() {
        // Given / When

        let countLimit = sut.imageCache.countLimit

        // Then

        XCTAssertGreaterThan(countLimit, 0)
    }
}
