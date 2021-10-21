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
}
