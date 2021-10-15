//
//  CharacterTablePresenter.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 14/10/21.
//

import Foundation

protocol CharacterTablePresentationLogic {
    func presentCharactersData(response: CharacterTable.FetchData.Response)
}

class CharacterTablePresenter: CharacterTablePresentationLogic {
    weak var viewController: CharacterTableDisplayLogic?

    func presentCharactersData(response: CharacterTable.FetchData.Response) {
        viewController?.displayCharacters(viewModel: .init(characters: response.characters))
    }
}
