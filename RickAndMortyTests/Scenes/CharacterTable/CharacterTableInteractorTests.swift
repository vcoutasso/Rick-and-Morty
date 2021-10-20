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
    private lazy var sut = CharacterTableInteractor(apiWorker: apiWorkerSpy, filterWorker: filterWorkerSpy)

    // MARK: - Test lifecycle

    override func setUp() {
        super.setUp()

        sut.presenter = presenterSpy
    }

    // MARK: - Unit tests

    func testFetchDataShouldFetchAllCharacters() {
        // Given

        let request: CharacterTable.FetchData.Request = .init()

        // When

        sut.fetchData(request: request)

        // Then

        XCTAssert(apiWorkerSpy.fetchAllCharactersCalled)
    }

    func testFetchDataShouldPassResponseToPresenter() {
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

    func testFilterDataShouldPassResponseToPresenter() {
        // Given

        let request: CharacterTable.FilterData.Request = .init(searchText: "")
        sut.characters = []

        // When

        sut.filterData(request: request)

        // Then

        XCTAssert(presenterSpy.presentFilteredDataCalled)
    }

}

final class CharacterTablePresenterSpy: CharacterTablePresentationLogic {
    private(set) var presentCharactersDataCalled = false
    func presentFetchedData(response: CharacterTable.FetchData.Response) {
        presentCharactersDataCalled = true
    }

    private(set) var presentFilteredDataCalled = false
    func presentFilteredData(response: CharacterTable.FilterData.Response) {
        presentFilteredDataCalled = true
    }
}

final class CharacterTableAPIWorkerSpy: CharacterTableAPIWorkerProtocol {
    private(set) var completionStub = [RMCharacter]()

    private(set) var fetchAllCharactersCalled = false
    func fetchAllCharacters(completion: @escaping ([RMCharacter]) -> Void) {
        fetchAllCharactersCalled = true
        completion(completionStub)
    }

    func fetchCurrentPage(completion: @escaping ([RMCharacter]) -> Void) {
        fatalError("not implemented")
    }
}

final class CharacterTableFilterWorkerSpy: CharacterTableFilterWorkerProtocol {
    private(set) var returnStub = [RMCharacter]()

    private(set) var filterCharactersCalled = false
    func filterCharacters(_ characters: [RMCharacter], contains searchText: String) -> [RMCharacter] {
        filterCharactersCalled = true
        return returnStub
    }
}
