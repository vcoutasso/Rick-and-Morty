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

protocol CharacterTableInteractorProtocol: CharacterTableBusinessLogic, CharacterTableDataStore {
    var presenter: CharacterTablePresenterProtocol { get set }
}

class CharacterTableInteractor: CharacterTableInteractorProtocol {
    var presenter: CharacterTablePresenterProtocol

    var apiWorker: CharacterTableAPIWorkerProtocol
    var filterWorker: CharacterTableFilterWorkerProtocol
    var favoritesWorker: FavoriteCharacterWorkerProtocol

    var characters: [RMCharacter]?

    // MARK: - Object lifecycle

    init(presenter: CharacterTablePresenterProtocol,
         apiWorker: CharacterTableAPIWorkerProtocol,
         filterWorker: CharacterTableFilterWorkerProtocol,
         favoritesWorker: FavoriteCharacterWorkerProtocol) {
        self.presenter = presenter
        self.apiWorker = apiWorker
        self.filterWorker = filterWorker
        self.favoritesWorker = favoritesWorker
    }

    // MARK: - Fetch Data

    func fetchData(request: CharacterTable.FetchData.Request) {
        apiWorker.fetchAllCharacters { characters in
            self.characters = characters
            let response = CharacterTable.FetchData.Response(characters: characters)

            self.presenter.presentFetchedData(response: response)
        }
    }

    // MARK: - Filter Data

    func filterData(request: CharacterTable.FilterData.Request) {
        guard let characters = characters else { return }

        let filteredCharacters = filterWorker.filterCharacters(characters, contains: request.searchText)
        let response = CharacterTable.FilterData.Response(characters: filteredCharacters)

        presenter.presentFilteredData(response: response)
    }
}
