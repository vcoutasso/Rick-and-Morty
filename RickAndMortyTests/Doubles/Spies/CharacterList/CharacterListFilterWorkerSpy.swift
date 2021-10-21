//
//  CharacterListFilterWorkerSpy.swift
//  RickAndMortyTests
//
//  Created by Vinícius Couto on 21/10/21.
//

import XCTest
@testable import RickAndMorty

final class CharacterListFilterWorkerSpy: CharacterListFilterWorkerProtocol {
    private(set) var returnStub = [RMCharacter]()

    private(set) var filterCharactersCalled = false
    func filterCharacters(_ characters: [RMCharacter], contains searchText: String) -> [RMCharacter] {
        filterCharactersCalled = true
        return returnStub
    }
}
