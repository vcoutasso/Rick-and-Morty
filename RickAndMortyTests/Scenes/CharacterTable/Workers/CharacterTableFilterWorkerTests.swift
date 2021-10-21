//
//  CharacterTableFilterWorkerTests.swift
//  RickAndMortyTests
//
//  Created by Vinícius Couto on 18/10/21.
//

import XCTest
@testable import RickAndMorty

class CharacterTableFilterWorkerTests: XCTestCase {
    // MARK: - Attributes

    private let sut = CharacterTableFilterWorker()

    // MARK: - Unit tests

    func testFilterCharactersShouldReturnAllOnEmptyString() {
        // Given

        let dummyCharacters = [Fixtures.RMCharacters.rick, Fixtures.RMCharacters.morty]
        let searchText = ""
        let expectedResult = dummyCharacters

        // When

        let actualResult = sut.filterCharacters(dummyCharacters, contains: searchText)

        // Then

        XCTAssertEqual(actualResult, expectedResult)
    }

    func testFilterCharactersShouldReturnOnlyMatches() {
        // Given

        let dummyCharacters = [Fixtures.RMCharacters.rick, Fixtures.RMCharacters.morty, Fixtures.RMCharacters.summer]
        let searchText = "smith"
        let expectedResult = [Fixtures.RMCharacters.morty, Fixtures.RMCharacters.summer]

        // When

        let actualResult = sut.filterCharacters(dummyCharacters, contains: searchText)

        // Then

        XCTAssertEqual(actualResult, expectedResult)
    }

    func testFilterCharactersShouldBeCaseInsensitive() {
        // Given

        let dummyCharacters = [Fixtures.RMCharacters.rick, Fixtures.RMCharacters.morty, Fixtures.RMCharacters.summer]
        let searchText = "sMiTH"
        let expectedResult = [Fixtures.RMCharacters.morty, Fixtures.RMCharacters.summer]

        // When

        let actualResult = sut.filterCharacters(dummyCharacters, contains: searchText)

        // Then

        XCTAssertEqual(actualResult, expectedResult)
    }
}
