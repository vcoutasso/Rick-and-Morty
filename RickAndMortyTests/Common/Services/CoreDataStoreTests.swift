//
//  CoreDataStoreTests.swift
//  RickAndMortyTests
//
//  Created by Vinícius Couto on 21/10/21.
//

import XCTest
@testable import RickAndMorty

final class CoreDataStoreTests: XCTestCase {
    // MARK: - Test doubles

    private let persistentContainerFake = PersistentContainerFake()
    private lazy var contextFake = persistentContainerFake.container.newBackgroundContext()

    // MARK: - Subject under test

    private lazy var sut = CoreDataStore(context: contextFake)

    // MARK: - Tests

    func testFetchFavoritedStatusShouldReturnFalseForNonexistentEntry() {
        // Given
        let characterID = Fixtures.RMCharacters.morty.id

        // When
        let isFavorite = sut.fetchFavoritedStatus(for: characterID)

        // Then
        XCTAssertFalse(isFavorite)
    }

    func testFetchFavoritedStatusShouldReturnTrueForExistentEntry() {
        // Given
        let characterID = Fixtures.RMCharacters.morty.id
        sut.addFavorite(id: characterID)

        // When
        let isFavorite = sut.fetchFavoritedStatus(for: characterID)

        // Then
        XCTAssert(isFavorite)
    }

    func testAddFavoriteShouldSaveContext() {
        // Given
        let characterID = Fixtures.RMCharacters.morty.id
        let saveContextExpectation = expectation(forNotification: .NSManagedObjectContextDidSave, object: contextFake) { _ in
            true
        }

        // When
        sut.addFavorite(id: characterID)

        // Then
        wait(for: [saveContextExpectation], timeout: 1)
    }

    func testRemoveFavoriteShouldSaveContextWhenChagesWereMade() {
        // Given
        let characterID = Fixtures.RMCharacters.morty.id
        sut.addFavorite(id: characterID)
        let saveContextExpectation = expectation(forNotification: .NSManagedObjectContextDidSave, object: contextFake) { _ in
            true
        }

        // When
        sut.removeFavorite(id: characterID)

        // Then
        wait(for: [saveContextExpectation], timeout: 1)
    }

    func testRemoveFavoriteShouldNotSaveContextWhenNoChanges() {
        // Given
        let characterID = Fixtures.RMCharacters.morty.id
        let saveContextExpectation = expectation(forNotification: .NSManagedObjectContextDidSave, object: contextFake) { _ in
            return true
        }
        saveContextExpectation.isInverted = true

        // When
        sut.removeFavorite(id: characterID)

        // Then
        wait(for: [saveContextExpectation], timeout: 1)
    }
}
