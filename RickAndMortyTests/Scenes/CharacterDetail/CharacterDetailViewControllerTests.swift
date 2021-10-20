//
//  CharacterDetailViewControllerTests.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 20/10/21.
//

@testable import RickAndMorty
import XCTest

final class CharacterDetailViewControllerTests: XCTestCase {
    // MARK: - Subject under test

    private var window =  UIWindow()
    private let routerSpy = CharacterDetailRouterSpy()
    private let interactorSpy = CharacterDetailInteractorSpy()
    private var sut = CharacterDetailViewController()

    // MARK: - Test lifecycle

    override func setUp() {
        routerSpy.dataStore = interactorSpy
        sut.interactor = interactorSpy
        sut.router = routerSpy
    }

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

final class CharacterDetailRouterSpy: NSObject, CharacterDetailRoutingLogic, CharacterDetailDataPassing {
    var dataStore: CharacterDetailDataStore?

    private(set) var setupCalled = false
    func setup() {
        setupCalled = true
    }
}

final class CharacterDetailInteractorSpy: CharacterDetailBusinessLogic, CharacterDetailDataStore {
    var character: RMCharacter! = Seeds.RMCharacters.morty

    private(set) var getCharacterCalled = false
    func getCharacter(request: CharacterDetail.Character.Request) {
        getCharacterCalled = true
    }
}
