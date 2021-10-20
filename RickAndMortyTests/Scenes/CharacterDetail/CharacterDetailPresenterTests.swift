//
//  CharacterDetailPresenterTests.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 20/10/21.
//

@testable import RickAndMorty
import XCTest

final class CharacterDetailPresenterTests: XCTestCase {
    // MARK: - Subject under test
    let spy = CharacterDetailViewControllerSpy()
    private lazy var sut = CharacterDetailPresenter()

    override func setUp() {
        sut.viewController = spy
    }

    func testPresentCharacterDetailShouldDisplayDetailView() {
        // Given
        let dummyCharacter = Seeds.RMCharacters.morty
        let response = CharacterDetail.Character.Response(character: dummyCharacter, isFavorite: false)

        // When
        sut.presentCharacterDetail(response: response)

        // Then
        XCTAssert(spy.displayDetailViewCalled)
    }
}

// MARK: - Test doubles

final class CharacterDetailViewControllerSpy: CharacterDetailViewController {
    private(set) var displayDetailViewCalled = false
    override func displayDetailView(viewModel: CharacterDetail.Character.ViewModel) {
        displayDetailViewCalled = true
    }
}
