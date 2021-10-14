//
//  CharacterListInteractor.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 14/10/21.
//

import Foundation

protocol CharacterListBusinessLogic {

}

protocol CharacterListDataStore {

}

class CharaterListInteractor: CharacterListBusinessLogic, CharacterListDataStore {
    var presenter: CharacterListPresentationLogic?
}
