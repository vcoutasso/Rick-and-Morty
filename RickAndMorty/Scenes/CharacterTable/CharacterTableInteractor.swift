//
//  CharacterTableInteractor.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 14/10/21.
//

import Foundation

protocol CharacterTableBusinessLogic {
    func fetchData(request: CharacterTable.FetchData.Request)
}

protocol CharacterTableDataStore {

}

class CharacterTableInteractor: CharacterTableBusinessLogic, CharacterTableDataStore {
    var presenter: CharacterTablePresentationLogic?

    // MARK: - Fetch Data

    func fetchData(request: CharacterTable.FetchData.Request) {
        switch request.type {
        case .all:
            fetchAllCharacters()
        case .id(let id):
            fetchCharacter(id: id)
        }
    }

    // MARK: - Private methods

    // TODO: Implement
    private func fetchAllCharacters() {
        let worker = CharacterTableWorker()
        worker.fetchAllCharacters { characters in
            print(characters)
        }
    }
    
    private func fetchCharacter(id: Int) {
    }
}
