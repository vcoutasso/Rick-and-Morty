//
//  CharacterDetailRouterSpy.swift
//  RickAndMortyTests
//
//  Created by Vinícius Couto on 21/10/21.
//

import XCTest
@testable import RickAndMorty

final class CharacterDetailRouterSpy: CharacterDetailRouterProtocol {
    var viewController: CharacterDetailViewController?

    var dataStore: CharacterDetailDataStore

    init(dataStore: CharacterDetailDataStore) {
        self.dataStore = dataStore
    }

    private(set) var setupCalled = false
    func setup() {
        setupCalled = true
    }
}
