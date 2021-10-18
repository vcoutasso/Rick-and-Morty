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
    private let sut = CharacterTableInteractor()

    // MARK: - Test lifecycle

    override func setUp() {
        super.setUp()

        sut.presenter = presenterSpy
        sut.apiWorker = apiWorkerSpy
    }

    // MARK: - Unit tests

    func testFetchDataShouldFetchAllCharacters() {
        // Given

        let request: CharacterTable.FetchData.Request = .init()

        // When

        sut.fetchData(request: request)

        // Then

        XCTAssertEqual(apiWorkerSpy.fetchAllCharactersCallCount, 1)
    }

    func testFetchDataShouldPassResponseToPresenter() {
        // Given

        let request: CharacterTable.FetchData.Request = .init()

        // When

        sut.fetchData(request: request)

        // Then

        XCTAssertEqual(presenterSpy.presentCharactersDataCallCount, 1)
    }

    func testFilterDataShould() {
        // Given

        let request: CharacterTable.FilterData.Request = .init(searchText: "")
        sut.characters = []

        // When

        sut.filterData(request: request)

        // Then

        XCTAssertEqual(presenterSpy.presentFilteredDataCallCount, 1)
    }

}

final class CharacterTablePresenterSpy: CharacterTablePresentationLogic {
    private(set) var presentCharactersDataCallCount = 0
    func presentFetchedData(response: CharacterTable.FetchData.Response) {
        presentCharactersDataCallCount += 1
    }

    private(set) var presentFilteredDataCallCount = 0
    func presentFilteredData(response: CharacterTable.FilterData.Response) {
        presentFilteredDataCallCount += 1
    }
}

final class CharacterTableAPIWorkerSpy: CharacterTableAPIWorkerProtocol {
    private(set) var fetchAllCharactersCallCount = 0
    private(set) var completionStub = [RMCharacter]()
    func fetchAllCharacters(completion: @escaping ([RMCharacter]) -> Void) {
        fetchAllCharactersCallCount += 1
        completion(completionStub)
    }

    func fetchCurrentPage(completion: @escaping ([RMCharacter]) -> Void) {
        fatalError("not implemented")
    }
}
