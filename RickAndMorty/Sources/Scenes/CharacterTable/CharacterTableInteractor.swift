//
//  CharacterTableInteractor.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 14/10/21.
//

import Foundation

protocol CharacterTableBusinessLogic {
    func fetchData(request: CharacterTable.FetchData.Request)
    func filterData(request: CharacterTable.FilterData.Request)
}

protocol CharacterTableDataStore {
    var characters: [RMCharacter]? { get }
}

class CharacterTableInteractor: CharacterTableBusinessLogic, CharacterTableDataStore {
    var presenter: CharacterTablePresentationLogic?

    var apiWorker: CharacterTableAPIWorkerProtocol
    var filterWorker: CharacterTableFilterWorkerProtocol

    var characters: [RMCharacter]?

    // MARK: - Object lifecycle

    init(apiWorker: CharacterTableAPIWorkerProtocol = CharacterTableAPIWorker(),
         filterWorker: CharacterTableFilterWorkerProtocol = CharacterTableFilterWorker()) {
        self.apiWorker = apiWorker
        self.filterWorker = filterWorker
    }

    // MARK: - Fetch Data

    func fetchData(request: CharacterTable.FetchData.Request) {
        apiWorker.fetchAllCharacters { characters in
            self.characters = characters
            let response = CharacterTable.FetchData.Response(characters: characters)

            self.presenter?.presentFetchedData(response: response)
        }
    }

    // MARK: - Filter Data

    func filterData(request: CharacterTable.FilterData.Request) {
        guard let characters = characters else { return }

        let filteredCharacters = filterWorker.filterCharacters(characters, contains: request.searchText)
        let response = CharacterTable.FilterData.Response(characters: filteredCharacters)

        self.presenter?.presentFilteredData(response: response)
    }
}
