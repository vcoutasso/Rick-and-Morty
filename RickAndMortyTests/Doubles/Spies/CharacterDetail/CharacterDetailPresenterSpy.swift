//
//  CharacterDetailPresenterSpy.swift
//  RickAndMortyTests
//
//  Created by Vinícius Couto on 21/10/21.
//

@testable import RickAndMorty
import XCTest

final class CharacterDetailPresenterSpy: CharacterDetailPresenterProtocol {
    var viewController: CharacterDetailDisplayLogic?

    private(set) var presentCharacterDetailCalled = false
    func presentCharacterDetail(response: CharacterDetail.Character.Response) {
      presentCharacterDetailCalled = true
    }

    private(set) var presentFavoriteIconCalled = false
    func presentFavoriteIcon(response: CharacterDetail.Favorite.Response) {
        presentFavoriteIconCalled = true
    }
}
