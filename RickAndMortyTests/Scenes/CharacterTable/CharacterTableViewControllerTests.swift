//
//  CharacterTableViewControllerTests.swift
//  RickAndMortyTests
//
//  Created by Vinícius Couto on 18/10/21.
//

import XCTest
@testable import RickAndMorty

class CharacterTableViewControllerTests: XCTestCase {
    // MARK: - Attributes

    private var window: UIWindow!
    private var sut: CharacterTableViewController!

    // MARK: - Test lifecycle

    override func setUp() {
        super.setUp()
        window = UIWindow()
        sut = .init()
    }

    override func tearDown() {
        window = nil
        sut = nil
    }

    // MARK: - Test setup

    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }

    // MARK: - Unit tests

    func testShouldSetupRouterWhenViewDidLoad() {
        // Given

        let characterTableRouterSpy = CharacterTableRouterSpy()
        sut.router =  characterTableRouterSpy
        loadView()

        // When

        sut.viewDidLoad()

        // Then

        XCTAssert(characterTableRouterSpy.setupCalled)
    }

    func testShouldFetchCharactersWhenViewDidLoad() {
        // Given

        let characterTableBusinessLogicSpy = CharacterTableBusinessLogicSpy()
        sut.interactor = characterTableBusinessLogicSpy
        loadView()

        // When

        sut.viewDidLoad()

        // Then

        XCTAssert(characterTableBusinessLogicSpy.fetchDataCalled)
    }

    func testShouldDisplayFetchedCharacters() {
        // Given

        let tableViewSpy = TableViewSpy()
        sut.tableView = tableViewSpy

        let dummySections = ["M", "R", "S"]
        let dummyCharacters = [[Seeds.RMCharacters.morty], [Seeds.RMCharacters.rick], [Seeds.RMCharacters.summer]]
        let dummyViewModel = CharacterTable.FetchData.ViewModel(characters: dummyCharacters, sections: dummySections)

        // When

        sut.displayCharacters(viewModel: dummyViewModel)

        // Then

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssert(tableViewSpy.reloadDataCalled)
        }
    }

    func testShouldDisplaySearchResults() {
        // Given

        let tableViewSpy = TableViewSpy()
        sut.tableView = tableViewSpy

        let dummySections = ["M", "R", "S"]
        let dummyCharacters = [[Seeds.RMCharacters.morty], [Seeds.RMCharacters.rick], [Seeds.RMCharacters.summer]]
        let dummyViewModel = CharacterTable.FilterData.ViewModel(characters: dummyCharacters, sections: dummySections)

        // When

        sut.displaySearchResults(viewModel: dummyViewModel)

        // Then

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssert(tableViewSpy.reloadDataCalled)
        }
    }

    func testShouldConfigureTableViewCellToDisplayCharacterData() {
        // Given

        let dummyCharacter = Seeds.RMCharacters.rick
        let dummyCharacters = [[dummyCharacter]]
        let dummySections = ["R"]
        let dummyViewModel = CharacterTable.FetchData.ViewModel(characters: dummyCharacters, sections: dummySections)
        sut.displayCharacters(viewModel: dummyViewModel)

        // When

        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.tableView(sut.tableView!, cellForRowAt: indexPath) as! CharacterTableViewCell

        // Then

        XCTAssertEqual(cell.character, dummyCharacter)
    }

    func testShouldRouteToDetailViewWhenSelectRow() {
        // Given

        let characterTableRouterSpy = CharacterTableRouterSpy()
        sut.router = characterTableRouterSpy

        let indexPath = IndexPath(row: 0, section: 0)
        let dummyCharacter = Seeds.RMCharacters.rick
        let dummyCharacters = [[dummyCharacter]]
        let dummySections = ["R"]
        let dummyViewModel = CharacterTable.FetchData.ViewModel(characters: dummyCharacters, sections: dummySections)
        sut.displayCharacters(viewModel: dummyViewModel)

        // When

        sut.tableView(sut.tableView, didSelectRowAt: indexPath)

        // Then

        XCTAssert(characterTableRouterSpy.routeToCharacterDetailCalled)
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
        // Given

        let characterTableBusinessLogicSpy = CharacterTableBusinessLogicSpy()
        sut.interactor = characterTableBusinessLogicSpy

        // When

        sut.searchBar(sut.searchController.searchBar, textDidChange: "")

        // Then

        XCTAssert(characterTableBusinessLogicSpy.filterDataCalled)
    }
}

// MARK: - Testing doubles

class CharacterTableRouterSpy: NSObject, CharacterTableRoutingLogic, CharacterTableDataPassing {
    var dataStore: CharacterTableDataStore?

    private(set) var setupCalled = false
    func setup() {
        setupCalled = true
    }

    private(set) var routeToCharacterDetailCalled = false
    func routeToCharacterDetail() {
        routeToCharacterDetailCalled = true
    }
}

class CharacterTableBusinessLogicSpy: CharacterTableBusinessLogic {
    private(set) var fetchDataCalled = false
    func fetchData(request: CharacterTable.FetchData.Request) {
        fetchDataCalled = true
    }

    private(set) var filterDataCalled = false
    func filterData(request: CharacterTable.FilterData.Request) {
        filterDataCalled = true
    }
}

class TableViewSpy: UITableView {
    private(set) var reloadDataCalled = false
    override func reloadData() {
        reloadDataCalled = true
    }
}
