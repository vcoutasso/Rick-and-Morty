//
//  CharacterListInteractorTests.swift
//  RickAndMortyTests
//
//  Created by Vinícius Couto on 16/10/21.
//

import XCTest
@testable import RickAndMorty

final class CharacterListInteractorTests: XCTestCase {

    // MARK: - Attributes

    private let presenterSpy = CharacterListPresenterSpy()
    private let apiWorkerSpy = CharacterListAPIWorkerSpy()
    private let filterWorkerSpy = CharacterListFilterWorkerSpy()
    private let managedObjectContextFake = PersistentContainerFake().container.viewContext
    private lazy var dataStoreDummy = CoreDataStoreDummy(context: managedObjectContextFake)
    private lazy var favoriteWorker = FavoriteCharacterWorker(context: managedObjectContextFake, dataStore: dataStoreDummy)
    private lazy var sut = CharacterListInteractor(presenter: presenterSpy, apiWorker: apiWorkerSpy, filterWorker: filterWorkerSpy, favoritesWorker: favoriteWorker)

    // MARK: - Unit tests

    func testFetchDataShouldFetchAllCharacters() {
        // Given
        let request: CharacterList.FetchData.Request = .init()

        // When
        sut.fetchData(request: request)

        // Then
        XCTAssert(apiWorkerSpy.fetchAllCharactersCalled)
    }

    func testFetchDataShouldCallPresentCharactersData() {
        // Given
        let request: CharacterList.FetchData.Request = .init()

        // When
        sut.fetchData(request: request)

        // Then
        XCTAssert(presenterSpy.presentCharactersDataCalled)
    }

    func testFilterDataShouldFilterData() {
        // Given
        let request: CharacterList.FilterData.Request = .init(searchText: "")
        sut.characters = [Fixtures.RMCharacters.morty]

        // When
        sut.filterData(request: request)

        // Then
        XCTAssert(filterWorkerSpy.filterCharactersCalled)
    }

    func testFilterDataShouldPresentFilteredData() {
        // Given
        let request: CharacterList.FilterData.Request = .init(searchText: "")
        sut.characters = [Fixtures.RMCharacters.morty]

        // When
        sut.filterData(request: request)

        // Then
        XCTAssert(presenterSpy.presentFilteredDataCalled)
    }

    func testShouldNotFilterDataWhenCharactersIsEmpty() {
        // Given
        let request: CharacterList.FilterData.Request = .init(searchText: "")
        sut.characters = []

        // When
        sut.filterData(request: request)

        // Then
        XCTAssertFalse(filterWorkerSpy.filterCharactersCalled)
    }

    func testShouldNotPresentFilteredDataWhenCharactersIsEmpty() {
        // Given
        let request: CharacterList.FilterData.Request = .init(searchText: "")
        sut.characters = []

        // When
        sut.filterData(request: request)

        // Then
        XCTAssertFalse(presenterSpy.presentFilteredDataCalled)
    }
}
