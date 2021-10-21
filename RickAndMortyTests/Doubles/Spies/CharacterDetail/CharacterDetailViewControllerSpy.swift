//
//  CharacterDetailViewControllerSpy.swift
//  RickAndMortyTests
//
//  Created by Vinícius Couto on 21/10/21.
//

import XCTest
@testable import RickAndMorty

final class CharacterDetailViewControllerSpy: CharacterDetailDisplayLogic {
    private(set) var displayDetailViewCalled = false
    func displayDetailView(viewModel: CharacterDetail.Character.ViewModel) {
        displayDetailViewCalled = true
    }

    private(set) var displayFavoriteButtonCalled = false
    private(set) var displayFavoriteButtonViewModelPassed: CharacterDetail.Favorite.ViewModel?
    func displayFavoriteButton(viewModel: CharacterDetail.Favorite.ViewModel) {
        displayFavoriteButtonCalled = true
        displayFavoriteButtonViewModelPassed = viewModel
    }
}
