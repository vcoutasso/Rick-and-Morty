//
//  CharacterTableInteractorTests.swift
//  RickAndMortyTests
//
//  Created by Vinícius Couto on 16/10/21.
//

import XCTest
@testable import RickAndMorty

final class CharacterTableInteractorTests: XCTestCase {

    // MARK: - Attributes

    private let presenterSpy = CharacterTablePresenterSpy()
    private let apiWorkerSpy = CharacterTableAPIWorkerSpy()
    private let filterWorkerSpy = CharacterTableFilterWorkerSpy()
    private let favoriteWorker = FavoriteCharacterWorker()
    private lazy var sut = CharacterTableInteractor(presenter: presenterSpy, apiWorker: apiWorkerSpy, filterWorker: filterWorkerSpy, favoritesWorker: favoriteWorker)

    // MARK: - Unit tests

    func testFetchDataShouldFetchAllCharacters() {
        // Given

        let request: CharacterTable.FetchData.Request = .init()

        // When

        sut.fetchData(request: request)

        // Then

        XCTAssert(apiWorkerSpy.fetchAllCharactersCalled)
    }

    func testFetchDDataShouldCallPresentCharactersData() {
        // Given

        let request: CharacterTable.FetchData.Request = .init()

        // When

        sut.fetchData(request: request)

        // Then

        XCTAssert(presenterSpy.presentCharactersDataCalled)
    }

    func testFilterDataShouldFilterData() {
        // Given

        let request: CharacterTable.FilterData.Request = .init(searchText: "")
        sut.characters = []

        // When

        sut.filterData(request: request)

        // Then
        XCTAssert(filterWorkerSpy.filterCharactersCalled)
    }

    func testFilterDataShouldPresentFilteredData() {
        // Given

        let request: CharacterTable.FilterData.Request = .init(searchText: "")
        sut.characters = []

        // When

        sut.filterData(request: request)

        // Then

        XCTAssert(presenterSpy.presentFilteredDataCalled)
    }

}
