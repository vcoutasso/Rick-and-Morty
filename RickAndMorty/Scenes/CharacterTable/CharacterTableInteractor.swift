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
    var worker: CharacterTableWorkerProtocol = CharacterTableWorker()

    // MARK: - Fetch Data

    func fetchData(request: CharacterTable.FetchData.Request) {
        switch request.type {
        case .all:
            fetchAllCharacters()
        case .id(_):
            break
        }
    }

    // MARK: - Private methods

    private func fetchAllCharacters() {
        worker.fetchAllCharacters { [weak self] characters in
            self?.presenter?.presentCharactersData(response: .init(characters: characters))
        }
    }
    
    private func fetchCharacter(id: Int) {
        // TODO: Implement
    }
}
