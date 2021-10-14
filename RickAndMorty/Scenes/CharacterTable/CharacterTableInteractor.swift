//
//  CharacterTableInteractor.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 14/10/21.
//

import Foundation

protocol CharacterTableBusinessLogic {

}

protocol CharacterTableDataStore {

}

class CharaterListInteractor: CharacterTableBusinessLogic, CharacterTableDataStore {
    var presenter: CharacterTablePresentationLogic?
}
