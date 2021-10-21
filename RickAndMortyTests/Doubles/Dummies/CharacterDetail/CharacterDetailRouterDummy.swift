//
//  CharacterDetailRouterDummy.swift
//  RickAndMortyTests
//
//  Created by Vinícius Couto on 21/10/21.
//

import XCTest
@testable import RickAndMorty

final class CharacterDetailRouterDummy: CharacterDetailRouterProtocol {
    var viewController: CharacterDetailViewController?
    var dataStore: CharacterDetailDataStore = CharacterDetailInteractorDummy()

    func setup() {
        fatalError("dummy double")
    }
}
