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
    var characters: [RMCharacter]? { get }
}

class CharacterTableInteractor: CharacterTableBusinessLogic, CharacterTableDataStore {
    var presenter: CharacterTablePresentationLogic?
    var worker: CharacterTableWorkerProtocol = CharacterTableWorker()

    var characters: [RMCharacter]?

    // MARK: - Fetch Data

    func fetchData(request: CharacterTable.FetchData.Request) {
        switch request.type {
        case .all:
            fetchAllCharacters()
        }
    }

    // MARK: - Private methods

    private func fetchAllCharacters() {
        worker.fetchAllCharacters { [weak self] characters in
            self?.characters = characters
            let response = CharacterTable.FetchData.Response(characters: characters)
            self?.presenter?.presentCharactersData(response: response)
        }
    }
}
