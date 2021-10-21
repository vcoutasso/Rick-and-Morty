//
//  CharacterDetailInteractorTests.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 20/10/21.
//

import XCTest
@testable import RickAndMorty

final class CharacterDetailInteractorTests: XCTestCase {
    // MARK: Test doubles

    private let presenterSpy = CharacterDetailPresenterSpy()
    private let favoriteWorkerSpy = FavoriteCharacterWorkerSpy()
    private let interactorSpy = CharacterDetailInteractorSpy(presenter: CharacterDetailPresenterDummy())
    private let routerSpy = CharacterDetailRouterSpy(dataStore: CharacterDetailDataStoreDummy())

    // MARK: - Subject under test
    
    private lazy var sut = CharacterDetailInteractor(presenter: presenterSpy, worker: favoriteWorkerSpy)

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

    func testGetCharacterShouldGetDataFromWorker() {
        // Given
        let dummyCharacter = Fixtures.RMCharacters.morty
        let request = CharacterDetail.Character.Request(character: dummyCharacter)

        // When
        sut.getCharacter(request: request)

        // Then
        XCTAssert(favoriteWorkerSpy.getFavoriteStatusCalled)
    }

    func testGetFavoriteShouldCallPresentFavoriteIcon() {
        // Given
        let dummyCharacterID = Fixtures.RMCharacters.morty.id
        let request = CharacterDetail.Favorite.Request(characterID: dummyCharacterID)

        // When
        sut.getFavorite(request: request)

        // Then
        XCTAssert(presenterSpy.presentFavoriteIconCalled)
    }

    func testSetFavoriteShouldGetDataFromWorker() {
        // Given
        let dummyCharacterID = Fixtures.RMCharacters.morty.id
        let request = CharacterDetail.Favorite.Request(characterID: dummyCharacterID)

        // When
        sut.setFavorite(request: request)

        // Then
        XCTAssert(favoriteWorkerSpy.getFavoriteStatusCalled)
    }

    func testSetFavoriteShouldToggleStatus() {
        // Given
        let dummyCharacterID = Fixtures.RMCharacters.morty.id
        let request = CharacterDetail.Favorite.Request(characterID: dummyCharacterID)

        // When
        sut.setFavorite(request: request)

        // Then
        XCTAssert(favoriteWorkerSpy.toggleFavoriteCalled)
    }

    func testSetFavoriteShouldCallPresentFavoriteIcon() {
        // Given
        let dummyCharacterID = Fixtures.RMCharacters.morty.id
        let request = CharacterDetail.Favorite.Request(characterID: dummyCharacterID)

        // When
        sut.setFavorite(request: request)

        // Then
        XCTAssert(presenterSpy.presentFavoriteIconCalled)
    }
}
