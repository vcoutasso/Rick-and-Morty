//
//  CharacterTableRouterSpy.swift
//  RickAndMortyTests
//
//  Created by Vinícius Couto on 21/10/21.
//

import XCTest
@testable import RickAndMorty

final class CharacterTableRouterSpy: CharacterTableRouterProtocol {
    var viewController: CharacterTableViewController?
    var dataStore: CharacterTableDataStore

    init(dataStore: CharacterTableDataStore) {
        self.dataStore = dataStore
    }

    private(set) var setupCalled = false
    func setup() {
        setupCalled = true
    }

    private(set) var routeToCharacterDetailCalled = false
    func routeToCharacterDetail() {
        routeToCharacterDetailCalled = true
    }
}
