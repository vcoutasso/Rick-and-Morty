//
//  CharacterDetailInteractor.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 17/10/21.
//

import UIKit

protocol CharacterDetailBusinessLogic {
    func doSomething(request: CharacterDetail.Character.Request)
}

protocol CharacterDetailDataStore {
    var character: RMCharacter! { get set }
}

class CharacterDetailInteractor: CharacterDetailBusinessLogic, CharacterDetailDataStore {
    var presenter: CharacterDetailPresentationLogic?
    var worker: CharacterDetailWorker?

    var character: RMCharacter!

    // MARK: Do something

    func doSomething(request: CharacterDetail.Character.Request) {
        character = request.character
        worker = CharacterDetailWorker()
        worker?.doSomeWork()
        
        let isFavorite = false

        let response = CharacterDetail.Character.Response(character: character!, isFavorite: isFavorite)
        presenter?.presentCharacterDetail(response: response)
    }
}
