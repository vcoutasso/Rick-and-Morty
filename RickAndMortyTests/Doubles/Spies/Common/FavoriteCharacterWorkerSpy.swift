//
//  FavoriteCharacterWorkerSpy.swift
//  RickAndMortyTests
//
//  Created by Vinícius Couto on 21/10/21.
//

import XCTest
@testable import RickAndMorty

final class FavoriteCharacterWorkerSpy: FavoriteCharacterWorkerProtocol {
    private(set) var getFavoriteStatusCalled = false
    func getFavoritedStatus(for id: Int) -> Bool {
        getFavoriteStatusCalled = true
        return .random()
    }

    private(set) var toggleFavoriteCalled = false
    func toggleFavorite(for id: Int) {
        toggleFavoriteCalled = true
    }
}
