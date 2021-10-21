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

    private let presenterSpy = CharacterDetailPresenterSpy()
    private let favoriteWorker = FavoriteCharacterWorker()
    private let interactorSpy = CharacterDetailInteractorSpy(presenter: CharacterDetailPresenterDummy())
    private let routerSpy = CharacterDetailRouterSpy(dataStore: CharacterDetailDataStoreDummy())
    private lazy var sut = CharacterDetailInteractor(presenter: presenterSpy, worker: favoriteWorker)

    // MARK: - Tests

    func testGetCharacterShouldCallPresentCharacterDetail() {
        // Given
        let dummyCharacter = Fixtures.RMCharacters.morty
        let request = CharacterDetail.Character.Request(character: dummyCharacter)

        // When
        sut.getCharacter(request: request)

        // Then
        XCTAssert(presenterSpy.presentCharacterDetailCalled)
    }
}
