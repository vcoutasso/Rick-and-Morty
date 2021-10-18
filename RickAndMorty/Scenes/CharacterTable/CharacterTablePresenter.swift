//
//  CharacterTablePresenter.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 14/10/21.
//

import Foundation

protocol CharacterTablePresentationLogic {
    func presentFetchedData(response: CharacterTable.FetchData.Response)
    func presentFilteredData(response: CharacterTable.FilterData.Response)
}

class CharacterTablePresenter: CharacterTablePresentationLogic {
    weak var viewController: CharacterTableDisplayLogic?

    // MARK: - Fetched data

    func presentFetchedData(response: CharacterTable.FetchData.Response) {
        let (characters, sections) = characterListToListOfSections(response.characters)
        let viewModel = CharacterTable.FetchData.ViewModel(characters: characters, sections: sections)
        viewController?.displayCharacters(viewModel: viewModel)
    }

    // MARK: - Filtered data

    func presentFilteredData(response: CharacterTable.FilterData.Response) {
        let (characters, sections) = characterListToListOfSections(response.characters)
        let viewModel = CharacterTable.FilterData.ViewModel(characters: characters, sections: sections)
        viewController?.displaySearchResults(viewModel: viewModel)
    }

    // MARK: - List to sections

    private func characterListToListOfSections(_ characters: [RMCharacter]) -> ([[RMCharacter]], [String]) {
        let sortedCharacters = characters.sorted { $0.name < $1.name }
        let sections = Set(sortedCharacters.map({ String($0.name.first!) })).sorted()
        let characters = sections.map { sectionName in
            sortedCharacters.filter { $0.name.starts(with: sectionName) }
        }

        return (characters, sections)
    }
}
