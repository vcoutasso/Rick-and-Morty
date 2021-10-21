//
//  CharacterListPresenterTests.swift
//  RickAndMortyTests
//
//  Created by Vinícius Couto on 16/10/21.
//

import XCTest
@testable import RickAndMorty

final class CharacterListPresenterTests: XCTestCase {
    // MARK: Attributse

    private let viewControllerSpy = CharacterListViewControllerSpy()
    private let sut = CharacterListPresenter()

    // MARK: Test lifecycle

    override func setUp() {
        super.setUp()

        sut.viewController = viewControllerSpy
    }

    // MARK: - Unit tests

    func testPresentCharactersDataShouldDisplayCharacters() {
        // Given

        let response: CharacterList.FetchData.Response = .init(characters: [])

        // When

        sut.presentFetchedData(response: response)

        // Then

        XCTAssert(viewControllerSpy.displayCharactersCalled)
    }

    func testPresentFilteredDataShouldDisplaySearchResults() {
        // Given

        let response: CharacterList.FilterData.Response = .init(characters: [])

        // When

        sut.presentFilteredData(response: response)

        // Then

        XCTAssert(viewControllerSpy.displaySearchResultsCalled)
    }

    func testCharacterListToListOfSections() {
        // Given

        let dummyCharacters = [Fixtures.RMCharacters.rick, Fixtures.RMCharacters.morty, Fixtures.RMCharacters.summer]
        let dummyResponse = CharacterList.FilterData.Response(characters: dummyCharacters)

        let sortedSectionNames = ["M", "R", "S"]
        let sortedSortedCharacters = [[Fixtures.RMCharacters.morty], [Fixtures.RMCharacters.rick], [Fixtures.RMCharacters.summer]]
        let expectedViewModel = CharacterList.FilterData.ViewModel(characters: sortedSortedCharacters, sections: sortedSectionNames)

        // When

        sut.presentFilteredData(response: dummyResponse)

        // Then

        XCTAssertEqual(viewControllerSpy.displaySearchResultsPassedViewModel, expectedViewModel)
    }
}
