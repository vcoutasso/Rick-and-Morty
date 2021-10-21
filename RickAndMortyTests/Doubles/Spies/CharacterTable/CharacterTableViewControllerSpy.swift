//
//  CharacterTableViewControllerSpy.swift
//  RickAndMortyTests
//
//  Created by Vinícius Couto on 21/10/21.
//

import XCTest
@testable import RickAndMorty

final class CharacterTableViewControllerSpy: CharacterTableDisplayLogic {
    private(set) var displayCharactersCalled = false
    private(set) var displayCharactersPassedViewModel: CharacterTable.FetchData.ViewModel?
    func displayCharacters(viewModel: CharacterTable.FetchData.ViewModel) {
        displayCharactersCalled = true
        displayCharactersPassedViewModel = viewModel
    }

    private(set) var displaySearchResultsCalled = false
    private(set) var displaySearchResultsPassedViewModel: CharacterTable.FilterData.ViewModel?
    func displaySearchResults(viewModel: CharacterTable.FilterData.ViewModel) {
        displaySearchResultsCalled = true
        displaySearchResultsPassedViewModel = viewModel
    }
}
