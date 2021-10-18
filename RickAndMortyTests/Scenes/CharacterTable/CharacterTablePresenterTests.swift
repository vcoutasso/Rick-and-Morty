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

        XCTAssertEqual(viewControllerSpy.displayCharactersCalled, true)
    }

    func testPresentFilteredDataShouldDisplaySearchResults() {
        // Given

        let response: CharacterTable.FilterData.Response = .init(characters: [])

        // When

        sut.presentFilteredData(response: response)

        // Then

        XCTAssertEqual(viewControllerSpy.displaySearchResultsCalled, true)
    }

    func testCharacterListToListOfSections() {
        // Given

        let dummyCharacters = [Seeds.RMCharacters.rick, Seeds.RMCharacters.morty, Seeds.RMCharacters.summer]
        let dummyResponse = CharacterTable.FilterData.Response(characters: dummyCharacters)

        let sortedSectionNames = ["M", "R", "S"]
        let sortedSortedCharacters = [[Seeds.RMCharacters.morty], [Seeds.RMCharacters.rick], [Seeds.RMCharacters.summer]]
        let expectedViewModel = CharacterTable.FilterData.ViewModel(characters: sortedSortedCharacters, sections: sortedSectionNames)

        // When

        sut.presentFilteredData(response: dummyResponse)

        // Then

        XCTAssertEqual(viewControllerSpy.displaySearchResultsPassedViewModel, expectedViewModel)
    }
}

// MARK: - Testing doubles

final class CharacterTableViewControllerSpy: CharacterTableDisplayLogic {
    private(set) var displayCharactersCalled = false
    private(set) var displayCharactersPassedViewModel: CharacterTable.FetchData.ViewModel?
    func displayCharacters(viewModel: CharacterTable.FetchData.ViewModel) {
        displayCharactersCalled = true
        displayCharactersPassedViewModel = viewModel
    }

    private(set) var displaySearchResultsCalled = false
    private(set) var displaySearchResultsPassedViewModel: CharacterTable.FilterData.ViewModel?
    func displaySearchResults(viewModel: CharacterTable.FilterData.ViewModel) {
        displaySearchResultsCalled = true
        displaySearchResultsPassedViewModel = viewModel
    }
}
