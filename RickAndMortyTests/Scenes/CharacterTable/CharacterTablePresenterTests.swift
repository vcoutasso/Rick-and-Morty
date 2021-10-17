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

        sut.presentCharactersData(response: response)

        // Then

        XCTAssertEqual(viewControllerSpy.displayCharactersCallCount, 1)
    }
}

// MARK: - Testing doubles

final class CharacterTableViewControllerSpy: CharacterTableDisplayLogic {
    private(set) var displayCharactersCallCount = 0
    func displayCharacters(viewModel: CharacterTable.FetchData.ViewModel) {
        displayCharactersCallCount += 1
    }
}