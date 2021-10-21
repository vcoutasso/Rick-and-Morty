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
        let dummyCharacter = Seeds.RMCharacters.morty
        let response = CharacterDetail.Character.Response(character: dummyCharacter, isFavorite: false)

        // When
        sut.presentCharacterDetail(response: response)

        // Then
        XCTAssert(viewControllerSpy.displayDetailViewCalled)
    }
}

// MARK: - Test doubles

final class CharacterDetailViewControllerSpy: CharacterDetailViewController {
    private(set) var displayDetailViewCalled = false
    override func displayDetailView(viewModel: CharacterDetail.Character.ViewModel) {
        displayDetailViewCalled = true
    }
}

final class FavoriteWorkerDummy: FavoriteCharacterWorkerProtocol {
    func getFavoritedStatus(for id: Int) -> Bool {
        fatalError("dummy double")
    }

    func toggleFavorite(for id: Int) {
        fatalError("dummy double")
    }
}

final class CharacterDetailRouterDummy: CharacterDetailRouterProtocol {
    var viewController: CharacterDetailViewController?
    var dataStore: CharacterDetailDataStore = CharacterDetailInteractorDummy()

    func setup() {
        fatalError("dummy double")
    }
}

final class CharacterDetailPresenterDummy: CharacterDetailPresenterProtocol {
    var viewController: CharacterDetailDisplayLogic?

    func presentCharacterDetail(response: CharacterDetail.Character.Response) {
        fatalError("dummy double")
    }

    func presentFavoriteIcon(response: CharacterDetail.Favorite.Response) {
        fatalError("dummy double")
    }
}
final class CharacterDetailInteractorDummy: CharacterDetailInteractorProtocol {
    var presenter: CharacterDetailPresenterProtocol = CharacterDetailPresenterDummy()
    var character: RMCharacter!

    func getCharacter(request: CharacterDetail.Character.Request) {
        fatalError("dummy double")
    }

    func getFavorite(request: CharacterDetail.Favorite.Request) {
        fatalError("dummy double")
    }

    func setFavorite(request: CharacterDetail.Favorite.Request) {
        fatalError("dummy double")
    }
}
