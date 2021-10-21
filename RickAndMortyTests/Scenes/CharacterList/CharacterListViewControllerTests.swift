//
//  CharacterListViewControllerTests.swift
//  RickAndMortyTests
//
//  Created by Vinícius Couto on 18/10/21.
//

import XCTest
@testable import RickAndMorty

class CharacterListViewControllerTests: XCTestCase {
    // MARK: - Attributes

    private let window = UIWindow()
    private let tableViewSpy = TableViewSpy()
    private let interactorSpy = CharacterListInteractorSpy(presenter: CharacterListPresenterDummy())
    private lazy var routerSpy = CharacterListRouterSpy(dataStore: interactorSpy)

    // MARK: - Subject under test

    private lazy var sut = CharacterListViewController(interactor: interactorSpy, router: routerSpy)

    // MARK: - Test setup

    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }

    // MARK: - Unit tests

    func testShouldSetupRouterWhenViewDidLoad() {
        // Given
        loadView()

        // When
        sut.viewDidLoad()

        // Then
        XCTAssert(routerSpy.setupCalled)
    }

    func testShouldFetchCharactersWhenViewDidLoad() {
        // Given
        loadView()

        // When
        sut.viewDidLoad()

        // Then
        XCTAssert(interactorSpy.fetchDataCalled)
    }

    func testShouldDisplayFetchedCharacters() {
        // Given
        sut.tableView = tableViewSpy

        let dummySections = ["M", "R", "S"]
        let dummyCharacters = [[Fixtures.RMCharacters.morty], [Fixtures.RMCharacters.rick], [Fixtures.RMCharacters.summer]]
        let dummyViewModel = CharacterList.FetchData.ViewModel(characters: dummyCharacters, sections: dummySections)

        // When
        sut.displayCharacters(viewModel: dummyViewModel)

        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssert(self.tableViewSpy.reloadDataCalled)
        }
    }

    func testShouldDisplaySearchResults() {
        // Given
        sut.tableView = tableViewSpy

        let dummySections = ["M", "R", "S"]
        let dummyCharacters = [[Fixtures.RMCharacters.morty], [Fixtures.RMCharacters.rick], [Fixtures.RMCharacters.summer]]
        let dummyViewModel = CharacterList.FilterData.ViewModel(characters: dummyCharacters, sections: dummySections)

        // When
        sut.displaySearchResults(viewModel: dummyViewModel)

        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssert(self.tableViewSpy.reloadDataCalled)
        }
    }

    func testShouldConfigureTableViewCellToDisplayCharacterData() {
        // Given
        let dummyCharacter = Fixtures.RMCharacters.rick
        let dummyCharacters = [[dummyCharacter]]
        let dummySections = ["R"]
        let dummyViewModel = CharacterList.FetchData.ViewModel(characters: dummyCharacters, sections: dummySections)
        sut.displayCharacters(viewModel: dummyViewModel)

        // When
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.tableView(sut.tableView!, cellForRowAt: indexPath) as! CharacterListViewCell

        // Then
        XCTAssertEqual(cell.character, dummyCharacter)
    }

    func testShouldRouteToDetailViewWhenSelectRow() {
        // Given
        let indexPath = IndexPath(row: 0, section: 0)
        let dummyCharacter = Fixtures.RMCharacters.rick
        let dummyCharacters = [[dummyCharacter]]
        let dummySections = ["R"]
        let dummyViewModel = CharacterList.FetchData.ViewModel(characters: dummyCharacters, sections: dummySections)
        sut.displayCharacters(viewModel: dummyViewModel)

        // When
        sut.tableView(sut.tableView, didSelectRowAt: indexPath)

        // Then
        XCTAssert(routerSpy.routeToCharacterDetailCalled)
    }

    func testShouldReloadDataOnPull() {
        // Given
        let tableViewSpy = TableViewSpy()
        sut.tableView = tableViewSpy
        loadView()

        // When
        sut.viewDidLoad()
        sut.tableView.setContentOffset(CGPoint(x: 0, y: -sut.refreshControl!.frame.size.height), animated: true)

        // Then
        XCTAssert(tableViewSpy.reloadDataCalled)
    }

    func testShouldFilterDataWhenSearchBarTextChanged() {
        // Given / When
        sut.searchBar(sut.searchController.searchBar, textDidChange: "")

        // Then
        XCTAssert(interactorSpy.filterDataCalled)
    }
}
