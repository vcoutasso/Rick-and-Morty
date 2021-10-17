//
//  CharacterDetailInteractor.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 17/10/21.
//

import UIKit

protocol CharacterDetailBusinessLogic {
    func doSomething(request: CharacterDetail.Something.Request)
}

protocol CharacterDetailDataStore {
    //var name: String { get set }
}

class CharacterDetailInteractor: CharacterDetailBusinessLogic, CharacterDetailDataStore {
    var presenter: CharacterDetailPresentationLogic?
    var worker: CharacterDetailWorker?
    //var name: String = ""

    // MARK: Do something

    func doSomething(request: CharacterDetail.Something.Request) {
        worker = CharacterDetailWorker()
        worker?.doSomeWork()

        let response = CharacterDetail.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
