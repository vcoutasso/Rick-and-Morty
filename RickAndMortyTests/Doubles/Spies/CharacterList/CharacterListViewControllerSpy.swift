//
//  CharacterListViewControllerSpy.swift
//  RickAndMortyTests
//
//  Created by Vinícius Couto on 21/10/21.
//

import XCTest
@testable import RickAndMorty

final class CharacterListViewControllerSpy: CharacterListDisplayLogic {
    private(set) var displayCharactersCalled = false
    private(set) var displayCharactersPassedViewModel: CharacterList.FetchData.ViewModel?
    func displayCharacters(viewModel: CharacterList.FetchData.ViewModel) {
        displayCharactersCalled = true
        displayCharactersPassedViewModel = viewModel
    }

    private(set) var displaySearchResultsCalled = false
    private(set) var displaySearchResultsPassedViewModel: CharacterList.FilterData.ViewModel?
    func displaySearchResults(viewModel: CharacterList.FilterData.ViewModel) {
        displaySearchResultsCalled = true
        displaySearchResultsPassedViewModel = viewModel
    }
}
