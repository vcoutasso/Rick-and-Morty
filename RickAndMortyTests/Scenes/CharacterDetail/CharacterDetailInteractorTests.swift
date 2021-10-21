//
//  CharacterDetailInteractorTests.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 20/10/21.
//

@testable import RickAndMorty
import XCTest

class CharacterDetailInteractorTests: XCTestCase {
    // MARK: - Subject under test

    private lazy var sut = CharacterDetailInteractor()

    // MARK: - Tests

    func testGetCharacterShouldCallPresentCharacterDetail() {
        // Given
        let spy = CharacterDetailPresentationLogicSpy()
        sut.presenter = spy
        let dummyCharacter = Seeds.RMCharacters.morty
        let request = CharacterDetail.Character.Request(character: dummyCharacter)

        // When
        sut.getCharacter(request: request)

        // Then
        XCTAssert(spy.presentCharacterDetailCalled)
    }
}

// MARK: - Test doubles

class CharacterDetailPresentationLogicSpy: CharacterDetailPresentationLogic {
    private(set) var presentCharacterDetailCalled = false
    func presentCharacterDetail(response: CharacterDetail.Character.Response) {
      presentCharacterDetailCalled = true
    }

    func presentFavoriteIcon(response: CharacterDetail.Favorite.Response) {
        fatalError("not implemented")
    }
}
