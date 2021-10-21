//
//  CharacterDetailPresenterTests.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 20/10/21.
//

import XCTest
@testable import RickAndMorty

final class CharacterDetailPresenterTests: XCTestCase {
    // MARK: - Test doubles

    private let viewControllerSpy = CharacterDetailViewControllerSpy()

    // MARK: - Subject under test

    private let sut = CharacterDetailPresenter()

    // MARK: - Test lifecycle

    override func setUp() {
        sut.viewController = viewControllerSpy
    }

    // MARK: - Tests

    func testPresentCharacterDetailShouldDisplayDetailView() {
        // Given
        let dummyCharacter = Fixtures.RMCharacters.morty
        let response = CharacterDetail.Character.Response(character: dummyCharacter, isFavorite: .random())

        // When
        sut.presentCharacterDetail(response: response)

        // Then
        XCTAssert(viewControllerSpy.displayDetailViewCalled)
    }

    func testPresentFavoriteIconShouldDisplayFavoriteButton() {
        // Given
        let response = CharacterDetail.Favorite.Response(isFavorite: .random())

        // When
        sut.presentFavoriteIcon(response: response)

        // Then
        XCTAssert(viewControllerSpy.displayFavoriteButtonCalled)
    }

    func testPresentFavoritIconShouldUseValidSymbolNameWhenFavorite() {
        // Given
        let isFavoriteStub = true
        let response = CharacterDetail.Favorite.Response(isFavorite: isFavoriteStub)

        // When
        sut.presentFavoriteIcon(response: response)

        // Then
        XCTAssert(viewControllerSpy.displayFavoriteButtonViewModelPassed!.image.isSymbolImage)
    }

    func testPresentFavoritIconShouldUseValidSymbolNameWhenNotFavorite() {
        // Given
        let isFavoriteStub = false
        let response = CharacterDetail.Favorite.Response(isFavorite: isFavoriteStub)

        // When
        sut.presentFavoriteIcon(response: response)

        // Then
        XCTAssert(viewControllerSpy.displayFavoriteButtonViewModelPassed!.image.isSymbolImage)
    }
}
