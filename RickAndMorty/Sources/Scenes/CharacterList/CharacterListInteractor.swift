//
//  CharacterListInteractor.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 14/10/21.
//

import Foundation

protocol CharacterListBusinessLogic {
    func fetchData(request: CharacterList.FetchData.Request)
    func filterData(request: CharacterList.FilterData.Request)
}

protocol CharacterListDataStore {
    var characters: [RMCharacter]? { get }
}

protocol CharacterListInteractorProtocol: CharacterListBusinessLogic, CharacterListDataStore {
    var presenter: CharacterListPresenterProtocol { get set }
}

class CharacterListInteractor: CharacterListInteractorProtocol {
    var presenter: CharacterListPresenterProtocol

    var apiWorker: CharacterListAPIWorkerProtocol
    var filterWorker: CharacterListFilterWorkerProtocol
    var favoritesWorker: FavoriteCharacterWorkerProtocol

    var characters: [RMCharacter]?

    // MARK: - Object lifecycle

    init(presenter: CharacterListPresenterProtocol,
         apiWorker: CharacterListAPIWorkerProtocol,
         filterWorker: CharacterListFilterWorkerProtocol,
         favoritesWorker: FavoriteCharacterWorkerProtocol) {
        self.presenter = presenter
        self.apiWorker = apiWorker
        self.filterWorker = filterWorker
        self.favoritesWorker = favoritesWorker
    }

    // MARK: - Fetch Data

    func fetchData(request: CharacterList.FetchData.Request) {
        apiWorker.fetchAllCharacters { characters in
            self.characters = characters
            let response = CharacterList.FetchData.Response(characters: characters)

            self.presenter.presentFetchedData(response: response)
        }
    }

    // MARK: - Filter Data

    func filterData(request: CharacterList.FilterData.Request) {
        guard let characters = characters else { return }

        let filteredCharacters = filterWorker.filterCharacters(characters, contains: request.searchText)
        let response = CharacterList.FilterData.Response(characters: filteredCharacters)

        presenter.presentFilteredData(response: response)
    }
}
