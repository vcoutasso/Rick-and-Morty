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
    private let workerSpy = CharacterTableWorkerSpy()
    private lazy var sut = CharacterTableInteractor()

    // MARK: - Test lifecycle

    override func setUp() {
        super.setUp()

        sut.presenter = presenterSpy
        sut.worker = workerSpy
    }

    // MARK: - Unit tests

    func testFetchDataShouldFetchAllCharacters() {
        // Given

        let request: CharacterTable.FetchData.Request = .init(type: .all)

        // When

        sut.fetchData(request: request)

        // Then

        XCTAssertEqual(workerSpy.fetchAllCharactersCallCount, 1)
    }

    func testFetchDataShouldPassResponseToPresenter() {
        // Given

        let request: CharacterTable.FetchData.Request = .init(type: .all)

        // When

        sut.fetchData(request: request)

        // Then

        XCTAssertEqual(presenterSpy.presentCharactersDataCallCount, 1)
    }

}

final class CharacterTablePresenterSpy: CharacterTablePresentationLogic {
    private(set) var presentCharactersDataCallCount = 0
    func presentCharactersData(response: CharacterTable.FetchData.Response) {
        presentCharactersDataCallCount += 1
    }
}

final class CharacterTableWorkerSpy: CharacterTableWorkerProtocol {
    private(set) var fetchAllCharactersCallCount = 0
    private(set) var completionStub = [CharacterTable.Character]()
    func fetchAllCharacters(completion: @escaping ([CharacterTable.Character]) -> Void) {
        fetchAllCharactersCallCount += 1
        completion(completionStub)
    }

    func fetchCurrentPage(completion: @escaping ([CharacterTable.Character]) -> Void) {
        fatalError("not implemented")
    }
}