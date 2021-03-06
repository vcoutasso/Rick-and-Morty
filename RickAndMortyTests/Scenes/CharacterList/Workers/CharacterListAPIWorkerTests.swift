//
//  CharacterListAPIWorkerTests.swift
//  RickAndMortyTests
//
//  Created by Vinícius Couto on 16/10/21.
//

import XCTest
@testable import RickAndMorty

final class CharacterListAPIWorkerTests: XCTestCase {
    // MARK: - Attributes

    private let sut = CharacterListAPIWorker()

    // MARK: - Stubs

    private let pageSizeStub = 20

    // MARK: - Setup

    override func setUp() {
        super.setUp()
    }

    // MARK: - Unit tests

    func testFetchCurrentPageShouldReturnFullPage() {
        // Given

        let completionExpectation = XCTestExpectation(description: "Completion should be called")
        var fetchResults = [RMCharacter]()

        // When

        sut.fetchCurrentPage { results in
            completionExpectation.fulfill()
            fetchResults = results
        }

        // Then

        wait(for: [completionExpectation], timeout: 10)
        XCTAssertEqual(fetchResults.count, pageSizeStub)
    }

    func testFetchAllCharactersShouldFetchMultiplePages() {
        // Given

        let completionExpectation = XCTestExpectation(description: "Completion should be called")
        var fetchResults = [RMCharacter]()

        // When

        sut.fetchAllCharacters { results in
            completionExpectation.fulfill()
            fetchResults = results
        }

        // Then

        wait(for: [completionExpectation], timeout: 20)
        XCTAssertGreaterThan(fetchResults.count, pageSizeStub)
    }
}
