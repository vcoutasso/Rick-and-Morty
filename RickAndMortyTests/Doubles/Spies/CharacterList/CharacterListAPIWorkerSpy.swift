//
//  CharacterListAPIWorkerSpy.swift
//  RickAndMortyTests
//
//  Created by Vinícius Couto on 21/10/21.
//

import XCTest
@testable import RickAndMorty

final class CharacterListAPIWorkerSpy: CharacterListAPIWorkerProtocol {
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
