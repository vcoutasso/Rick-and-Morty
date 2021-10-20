//
//  CharacterDetailInteractor.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 17/10/21.
//

import UIKit

protocol CharacterDetailBusinessLogic {
    func getCharacter(request: CharacterDetail.Character.Request)
    func favoriteItem(request: CharacterDetail.Favorite.Request)
}

protocol CharacterDetailDataStore {
    var character: RMCharacter! { get set }
}

class CharacterDetailInteractor: CharacterDetailBusinessLogic, CharacterDetailDataStore {
    var presenter: CharacterDetailPresentationLogic?
    var worker: CharacterDetailWorker?

    var character: RMCharacter!

    // MARK: - Get character

    func getCharacter(request: CharacterDetail.Character.Request) {
        character = request.character

        let isFavorite = false

        let response = CharacterDetail.Character.Response(character: character!, isFavorite: isFavorite)
        presenter?.presentCharacterDetail(response: response)
    }

    // MARK: - Favorite item

    func favoriteItem(request: CharacterDetail.Favorite.Request) {
        // TODO: Worker must get this from database
        let isFavorite = Bool.random()

        let response = CharacterDetail.Favorite.Response(isFavorite: isFavorite)
        presenter?.presentFavoriteIcon(response: response)
    }
}
