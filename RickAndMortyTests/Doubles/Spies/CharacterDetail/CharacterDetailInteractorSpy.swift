//
//  CharacterDetailInteractorSpy.swift
//  RickAndMortyTests
//
//  Created by Vinícius Couto on 21/10/21.
//

import XCTest
@testable import RickAndMorty

final class CharacterDetailInteractorSpy: CharacterDetailInteractorProtocol {
    var character: RMCharacter! = Fixtures.RMCharacters.morty
    var presenter: CharacterDetailPresenterProtocol

    init(presenter: CharacterDetailPresenterProtocol) {
        self.presenter = presenter
    }

    private(set) var getCharacterCalled = false
    func getCharacter(request: CharacterDetail.Character.Request) {
        getCharacterCalled = true
    }

    func getFavorite(request: CharacterDetail.Favorite.Request) {
        print("not implemented")
    }

    func setFavorite(request: CharacterDetail.Favorite.Request) {
        print("not implemented")
    }
}
