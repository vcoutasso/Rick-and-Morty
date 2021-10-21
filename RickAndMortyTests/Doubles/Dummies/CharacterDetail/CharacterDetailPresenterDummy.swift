//
//  CharacterDetailPresenterDummy.swift
//  RickAndMortyTests
//
//  Created by Vinícius Couto on 21/10/21.
//

import XCTest
@testable import RickAndMorty

final class CharacterDetailPresenterDummy: CharacterDetailPresenterProtocol {
    var viewController: CharacterDetailDisplayLogic?

    func presentCharacterDetail(response: CharacterDetail.Character.Response) {
        fatalError("dummy double")
    }

    func presentFavoriteIcon(response: CharacterDetail.Favorite.Response) {
        fatalError("dummy double")
    }
}
