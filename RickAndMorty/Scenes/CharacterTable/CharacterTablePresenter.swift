//
//  CharacterTablePresenter.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 14/10/21.
//

import Foundation

protocol CharacterTablePresentationLogic {
    func presentFetchedData(response: CharacterTable.FetchData.Response)
}

class CharacterTablePresenter: CharacterTablePresentationLogic {
    weak var viewController: CharacterTableDisplayLogic?

    func presentFetchedData(response: CharacterTable.FetchData.Response) {
        let characters = response.characters
        let viewModel = CharacterTable.FetchData.ViewModel(characters: characters)
        viewController?.displayCharacters(viewModel: viewModel)
    }
}
