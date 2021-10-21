//
//  CharacterDetailInteractor.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 17/10/21.
//

import UIKit

protocol CharacterDetailBusinessLogic {
    func getCharacter(request: CharacterDetail.Character.Request)
    func getFavorite(request: CharacterDetail.Favorite.Request)
    func setFavorite(request: CharacterDetail.Favorite.Request)
}

protocol CharacterDetailDataStore {
    var character: RMCharacter! { get set }
}

protocol CharacterDetailInteractorProtocol: CharacterDetailBusinessLogic, CharacterDetailDataStore {
    var presenter: CharacterDetailPresenterProtocol { get set }
}

class CharacterDetailInteractor: CharacterDetailInteractorProtocol {
    var presenter: CharacterDetailPresenterProtocol
    var worker: FavoriteCharacterWorkerProtocol

    var character: RMCharacter!

    // MARK: - Object lifecycle

    init(presenter: CharacterDetailPresenterProtocol,
         worker: FavoriteCharacterWorker) {
        self.presenter = presenter
        self.worker = worker
    }

    // MARK: - Get character

    func getCharacter(request: CharacterDetail.Character.Request) {
        character = request.character

        let isFavorite = isFavorite(id: character.id)

        let response = CharacterDetail.Character.Response(character: character!, isFavorite: isFavorite)
        presenter.presentCharacterDetail(response: response)
    }

    // MARK: - Get favorite

    func getFavorite(request: CharacterDetail.Favorite.Request) {
        let id = request.characterID
        let isFavorite = isFavorite(id: id)

        let response = CharacterDetail.Favorite.Response(isFavorite: isFavorite)
        presenter.presentFavoriteIcon(response: response)
    }

    // MARK: - Set favorite

    func setFavorite(request: CharacterDetail.Favorite.Request) {
        let id = request.characterID
        worker.toggleFavorite(for: id)

        let isFavorite = isFavorite(id: id)

        let response = CharacterDetail.Favorite.Response(isFavorite: isFavorite)
        presenter.presentFavoriteIcon(response: response)
    }

    // MARK: - Convenience methods

    private func isFavorite(id: Int) -> Bool {
        worker.getFavoritedStatus(for: id)
    }
}
