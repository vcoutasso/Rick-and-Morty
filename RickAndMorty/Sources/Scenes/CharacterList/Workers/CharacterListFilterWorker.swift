//
//  CharacterListFilterWorker.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 18/10/21.
//

import Foundation

protocol CharacterListFilterWorkerProtocol {
    func filterCharacters(_ characters: [RMCharacter], contains searchText: String) -> [RMCharacter]
}

class CharacterListFilterWorker: CharacterListFilterWorkerProtocol {
    func filterCharacters(_ characters: [RMCharacter], contains searchText: String) -> [RMCharacter] {
        searchText.isEmpty ? characters : characters.filter { $0.name.lowercased().contains(searchText.lowercased()) }
    }
}
