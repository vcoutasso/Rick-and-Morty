//
//  FavoriteCharacterWorkerTests.swift
//  RickAndMortyTests
//
//  Created by Vinícius Couto on 21/10/21.
//

import XCTest
@testable import RickAndMorty

final class FavoriteCharacterWorkerTests: XCTestCase {
    // MARK: - Test doubles

    private let contextFake = PersistentContainerFake().container.newBackgroundContext()
    private lazy var dataStoreSpy = CoreDataStoreSpy(context: contextFake)

    // MARK: - Subject under test

    private lazy var sut = FavoriteCharacterWorker(context: contextFake, dataStore: dataStoreSpy)

    // MARK: - Test

    // MARK: - Tests

    func testGetFavoritedStatusShouldFetchFromDataStore() {
        // Given
        let dummyID = Fixtures.RMCharacters.morty.id

        // When
        _ = sut.getFavoritedStatus(for: dummyID)

        // Then
        XCTAssert(dataStoreSpy.fetchFavoritedStatusCalled)
    }

    func testToggleFavoriteShouldFetchCurrentStatusFromDataStore() {
        // Given
        let dummyID = Fixtures.RMCharacters.morty.id

        // When
        sut.toggleFavorite(for: dummyID)

        // Then
        XCTAssert(dataStoreSpy.fetchFavoritedStatusCalled)
    }

    func testToggleFavoriteShouldRemoveEntriesWhenExists() {
        // Given
        let dummyID = Fixtures.RMCharacters.morty.id
        dataStoreSpy.fetchFavoritedStatusStub = true

        // When
        sut.toggleFavorite(for: dummyID)

        // Then
        XCTAssert(dataStoreSpy.removeFavoriteCalled)
    }

    func testToggleFavoriteShouldAddEntriesWhenNonexistent() {
        // Given
        let dummyID = Fixtures.RMCharacters.morty.id
        dataStoreSpy.fetchFavoritedStatusStub = false

        // When
        sut.toggleFavorite(for: dummyID)

        // Then
        XCTAssert(dataStoreSpy.addFavoriteCalled)
    }
}
