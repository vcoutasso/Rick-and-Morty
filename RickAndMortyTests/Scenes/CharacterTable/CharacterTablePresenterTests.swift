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

        XCTAssertEqual(viewControllerSpy.displayCharactersCallCount, 1)
    }

    func testPresentFilteredDataShouldDisplaySearchResults() {
        // Given

        let response: CharacterTable.FilterData.Response = .init(characters: [])

        // When

        sut.presentFilteredData(response: response)

        // Then

        XCTAssertEqual(viewControllerSpy.displaySearchResultsCallCount, 1)
    }
}

// MARK: - Testing doubles

final class CharacterTableViewControllerSpy: CharacterTableDisplayLogic {
    private(set) var displayCharactersCallCount = 0
    func displayCharacters(viewModel: CharacterTable.FetchData.ViewModel) {
        displayCharactersCallCount += 1
    }

    private(set) var displaySearchResultsCallCount = 0
    func displaySearchResults(viewModel: CharacterTable.FilterData.ViewModel) {
        displaySearchResultsCallCount += 1
    }
}
