//
//  CharacterDetailPresenterTests.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 20/10/21.
//

@testable import RickAndMorty
import XCTest

final class CharacterDetailPresenterTests: XCTestCase {
    // MARK: - Attributes

    private let routerDummy = CharacterDetailRouterDummy()
    private let interactorDummy = CharacterDetailInteractorDummy()
    private lazy var viewControllerSpy = CharacterDetailViewControllerSpy(interactor: interactorDummy, router: routerDummy)

    // MARK: - Subject under test

    private let sut = CharacterDetailPresenter()

    override func setUp() {
        sut.viewController = viewControllerSpy
    }

    func testPresentCharacterDetailShouldDisplayDetailView() {
        // Given
        let dummyCharacter = Fixtures.RMCharacters.morty
        let response = CharacterDetail.Character.Response(character: dummyCharacter, isFavorite: false)

        // When
        sut.presentCharacterDetail(response: response)

        // Then
        XCTAssert(viewControllerSpy.displayDetailViewCalled)
    }
}
