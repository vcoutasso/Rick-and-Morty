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

class CharacterDetailInteractor: CharacterDetailBusinessLogic, CharacterDetailDataStore {
    var presenter: CharacterDetailPresentationLogic?
    var worker: CharacterDetailWorker? = CharacterDetailWorker()

    var character: RMCharacter!

    // MARK: - Get character

    func getCharacter(request: CharacterDetail.Character.Request) {
        character = request.character

        let isFavorite = false

        let response = CharacterDetail.Character.Response(character: character!, isFavorite: isFavorite)
        presenter?.presentCharacterDetail(response: response)
    }

    // MARK: - Get/set favorite

    func getFavorite(request: CharacterDetail.Favorite.Request) {
        guard let worker = worker else { return }

        let id = request.characterID
        var isFavorite = false

        isFavorite = worker.fetchFavoritedStatus(for: id)

        let response = CharacterDetail.Favorite.Response(isFavorite: isFavorite)
        presenter?.presentFavoriteIcon(response: response)
    }

    func setFavorite(request: CharacterDetail.Favorite.Request) {
        guard let worker = worker else { return }

        let id = request.characterID
        var isFavorite = false

        isFavorite = worker.fetchFavoritedStatus(for: id)

        if isFavorite {
            worker.removeFavorite(id: id)
        } else {
            worker.addFavorite(id: id)
        }

        let response = CharacterDetail.Favorite.Response(isFavorite: !isFavorite)
        presenter?.presentFavoriteIcon(response: response)
    }
}
