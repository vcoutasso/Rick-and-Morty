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

        let dummyCharacters = [Seeds.RMCharacters.rick, Seeds.RMCharacters.morty]
        let searchText = ""
        let expectedResult = dummyCharacters

        // When

        let actualResult = sut.filterCharacters(dummyCharacters, contains: searchText)

        // Then

        XCTAssertEqual(actualResult, expectedResult)
    }

    func testFilterCharactersShouldReturnOnlyMatches() {
        // Given

        let dummyCharacters = [Seeds.RMCharacters.rick, Seeds.RMCharacters.morty, Seeds.RMCharacters.summer]
        let searchText = "smith"
        let expectedResult = [Seeds.RMCharacters.morty, Seeds.RMCharacters.summer]

        // When

        let actualResult = sut.filterCharacters(dummyCharacters, contains: searchText)

        // Then

        XCTAssertEqual(actualResult, expectedResult)
    }

    func testFilterCharactersShouldBeCaseInsensitive() {
        // Given

        let dummyCharacters = [Seeds.RMCharacters.rick, Seeds.RMCharacters.morty, Seeds.RMCharacters.summer]
        let searchText = "sMiTH"
        let expectedResult = [Seeds.RMCharacters.morty, Seeds.RMCharacters.summer]

        // When

        let actualResult = sut.filterCharacters(dummyCharacters, contains: searchText)

        // Then

        XCTAssertEqual(actualResult, expectedResult)
    }
}
