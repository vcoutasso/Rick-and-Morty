//
//  CharacterDetailViewControllerTests.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 20/10/21.
//

@testable import RickAndMorty
import XCTest

final class CharacterDetailViewControllerTests: XCTestCase {
    // MARK: - Attributse
    private var window =  UIWindow()
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
}

// MARK: - Test doubles

final class CharacterDetailRouterSpy: CharacterDetailRouterProtocol {
    var viewController: CharacterDetailViewController?

    var dataStore: CharacterDetailDataStore

    init(dataStore: CharacterDetailDataStore) {
        self.dataStore = dataStore
    }

    private(set) var setupCalled = false
    func setup() {
        setupCalled = true
    }
}

final class CharacterDetailDataStoreDummy: CharacterDetailDataStore {
    var character: RMCharacter!
}

final class CharacterDetailInteractorSpy: CharacterDetailInteractorProtocol {
    var character: RMCharacter! = Seeds.RMCharacters.morty
    var presenter: CharacterDetailPresenterProtocol

    init(presenter: CharacterDetailPresenterProtocol) {
        self.presenter = presenter
    }

    private(set) var getCharacterCalled = false
    func getCharacter(request: CharacterDetail.Character.Request) {
        getCharacterCalled = true
    }

    func getFavorite(request: CharacterDetail.Favorite.Request) {
        print("not implemented")
    }

    func setFavorite(request: CharacterDetail.Favorite.Request) {
        print("not implemented")
    }
}
