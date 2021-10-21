//
//  CharacterTablePresenterTests.swift
//  RickAndMortyTests
//
//  Created by Vinícius Couto on 16/10/21.
//

import XCTest
@testable import RickAndMorty

final class CharacterTablePresenterTests: XCTestCase {
    // MARK: Attributse

    private let viewControllerSpy = CharacterTableViewControllerSpy()
    private let sut = CharacterTablePresenter()

    // MARK: Test lifecycle

    override func setUp() {
        super.setUp()

        sut.viewController = viewControllerSpy
    }

    // MARK: - Unit tests

    func testPresentCharactersDataShouldDisplayCharacters() {
        // Given

        let response: CharacterTable.FetchData.Response = .init(characters: [])

        // When

        sut.presentFetchedData(response: response)

        // Then

        XCTAssert(viewControllerSpy.displayCharactersCalled)
    }

    func testPresentFilteredDataShouldDisplaySearchResults() {
        // Given

        let response: CharacterTable.FilterData.Response = .init(characters: [])

        // When

        sut.presentFilteredData(response: response)

        // Then

        XCTAssert(viewControllerSpy.displaySearchResultsCalled)
    }

    func testCharacterListToListOfSections() {
        // Given

        let dummyCharacters = [Fixtures.RMCharacters.rick, Fixtures.RMCharacters.morty, Fixtures.RMCharacters.summer]
        let dummyResponse = CharacterTable.FilterData.Response(characters: dummyCharacters)

        let sortedSectionNames = ["M", "R", "S"]
        let sortedSortedCharacters = [[Fixtures.RMCharacters.morty], [Fixtures.RMCharacters.rick], [Fixtures.RMCharacters.summer]]
        let expectedViewModel = CharacterTable.FilterData.ViewModel(characters: sortedSortedCharacters, sections: sortedSectionNames)

        // When

        sut.presentFilteredData(response: dummyResponse)

        // Then

        XCTAssertEqual(viewControllerSpy.displaySearchResultsPassedViewModel, expectedViewModel)
    }
}
