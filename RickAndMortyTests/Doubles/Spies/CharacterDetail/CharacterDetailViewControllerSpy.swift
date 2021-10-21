//
//  CharacterDetailViewControllerSpy.swift
//  RickAndMortyTests
//
//  Created by Vinícius Couto on 21/10/21.
//

import XCTest
@testable import RickAndMorty

final class CharacterDetailViewControllerSpy: CharacterDetailViewController {
    private(set) var displayDetailViewCalled = false
    override func displayDetailView(viewModel: CharacterDetail.Character.ViewModel) {
        displayDetailViewCalled = true
    }
}
