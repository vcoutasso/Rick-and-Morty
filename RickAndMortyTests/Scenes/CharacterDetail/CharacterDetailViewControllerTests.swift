//
//  CharacterDetailViewControllerTests.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 20/10/21.
//

@testable import RickAndMorty
import XCTest

final class CharacterDetailViewControllerTests: XCTestCase {
    // MARK: - Attributes

    private let window =  UIWindow()

    // MARK: - Test doubles

    private let interactorSpy = CharacterDetailInteractorSpy(presenter: CharacterDetailPresenterDummy())
    private lazy var routerSpy = CharacterDetailRouterSpy(dataStore: interactorSpy)

    // MARK: - Subject under test

    private lazy var sut = CharacterDetailViewController(interactor: interactorSpy, router: routerSpy)

    // MARK: - Test setup

    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }

    // MARK: - Tests

    func testShouldSetupRouterWhenViewDidLoad() {
        // Given
        loadView()

        // When
        sut.viewDidLoad()

        // Then
        XCTAssert(routerSpy.setupCalled)
    }

    func testShouldGetCharacterWhenViewDidLoad() {
        // Given
        loadView()

        // When
        sut.viewDidLoad()

        // Then
        XCTAssert(interactorSpy.getCharacterCalled)
    }

    func testShouldGetFavoriteStatusWhenViewDidLoad() {
        // Given
        loadView()

        // When
        sut.viewDidLoad()

        // Then
        XCTAssert(interactorSpy.getFavoriteCalled)
    }

    func testShouldSetupRoutingWhenWillMoveToParent() {
        // Given / When
        sut.willMove(toParent: nil)

        // Then
        XCTAssert(routerSpy.setupCalled)
    }

    func testShouldSetFavoriteButtonWhenFavoriteTapped() {
        // Given / When
        sut.handleFavoriteTapped()

        // Then
        XCTAssert(interactorSpy.setFavoriteCalled)
    }

    func testShouldResetNavigationBarRightButtonItemsWhenViewWillDisappear() {
        // Given
        let rightBarButtonDummy = UIBarButtonItem()
        sut.navigationItem.setRightBarButton(rightBarButtonDummy, animated: .random())

        // When
        sut.viewWillDisappear(.random())

        // Then
        XCTAssertNil(sut.navigationItem.rightBarButtonItems)
    }

    func testShouldSetNavigationBarRightButtonItemsWhenDisplayFavoriteButton() {
        // Given
        let dummyImage = UIImage()
        let viewModel = CharacterDetail.Favorite.ViewModel(image: dummyImage)
        sut.navigationItem.setRightBarButton(UIBarButtonItem(), animated: .random())

        // When
        sut.displayFavoriteButton(viewModel: viewModel)

        // Then
        XCTAssertNotNil(sut.navigationItem.rightBarButtonItem?.image)
    }

    func testDisplayDetailViewShouldSetCharacterData() {
        // Given
        let dummyCharacter = Fixtures.RMCharacters.morty
        let viewModel = CharacterDetail.Character.ViewModel(id: dummyCharacter.id, name: dummyCharacter.name, status: dummyCharacter.status, species: dummyCharacter.species, type: dummyCharacter.type, gender: dummyCharacter.gender, imageLink: dummyCharacter.image)
        let detailView = sut.detailView
        detailView.characterData = nil


        // When
        sut.displayDetailView(viewModel: viewModel)

        // Then
        XCTAssertNotNil(detailView.characterData)
    }
}
