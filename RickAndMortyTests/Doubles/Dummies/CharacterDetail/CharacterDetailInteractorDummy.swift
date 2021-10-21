//
//  CharacterDetailInteractorDummy.swift
//  RickAndMortyTests
//
//  Created by Vinícius Couto on 21/10/21.
//

import XCTest
@testable import RickAndMorty

final class CharacterDetailInteractorDummy: CharacterDetailInteractorProtocol {
    var presenter: CharacterDetailPresenterProtocol = CharacterDetailPresenterDummy()
    var character: RMCharacter!

    func getCharacter(request: CharacterDetail.Character.Request) {
        fatalError("dummy double")
    }

    func getFavorite(request: CharacterDetail.Favorite.Request) {
        fatalError("dummy double")
    }

    func setFavorite(request: CharacterDetail.Favorite.Request) {
        fatalError("dummy double")
    }
}
