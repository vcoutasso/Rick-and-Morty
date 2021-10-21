//
//  CharacterListPresenter.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 14/10/21.
//

import Foundation

protocol CharacterListPresentationLogic {
    func presentFetchedData(response: CharacterList.FetchData.Response)
    func presentFilteredData(response: CharacterList.FilterData.Response)
}

protocol CharacterListPresenterProtocol: CharacterListPresentationLogic {
    var viewController: CharacterListDisplayLogic? { get set }
}

class CharacterListPresenter: CharacterListPresenterProtocol {
    weak var viewController: CharacterListDisplayLogic?

    // MARK: - Present fetched data

    func presentFetchedData(response: CharacterList.FetchData.Response) {
        let (characters, sections) = characterListToListOfSections(response.characters)
        let viewModel = CharacterList.FetchData.ViewModel(characters: characters, sections: sections)
        viewController?.displayCharacters(viewModel: viewModel)
    }

    // MARK: - Present filtered data

    func presentFilteredData(response: CharacterList.FilterData.Response) {
        let (characters, sections) = characterListToListOfSections(response.characters)
        let viewModel = CharacterList.FilterData.ViewModel(characters: characters, sections: sections)
        viewController?.displaySearchResults(viewModel: viewModel)
    }

    // MARK: - Convert list to sections

    private func characterListToListOfSections(_ characters: [RMCharacter]) -> ([[RMCharacter]], [String]) {
        let sortedCharacters = characters.sorted { $0.name < $1.name }
        let sections = Set(sortedCharacters.map({ String($0.name.first!) })).sorted()
        let characters = sections.map { sectionName in
            sortedCharacters.filter { $0.name.starts(with: sectionName) }
        }

        return (characters, sections)
    }
}
