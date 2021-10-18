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
        let sortedCharacters = response.characters.sorted { $0.name < $1.name }
        let sections = Set(sortedCharacters.map({ String($0.name.first!) })).sorted()
        let characters = sections.map { sectionName in
            sortedCharacters.filter { $0.name.starts(with: sectionName) }
        }
        let viewModel = CharacterTable.FetchData.ViewModel(characters: characters, sections: sections)
        viewController?.displayCharacters(viewModel: viewModel)
    }
}
