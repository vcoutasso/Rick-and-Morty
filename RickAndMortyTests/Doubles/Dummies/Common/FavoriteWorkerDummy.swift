//
//  FavoriteWorkerDummy.swift
//  RickAndMortyTests
//
//  Created by Vinícius Couto on 21/10/21.
//

import XCTest
@testable import RickAndMorty

final class FavoriteWorkerDummy: FavoriteCharacterWorkerProtocol {
    func getFavoritedStatus(for id: Int) -> Bool {
        fatalError("dummy double")
    }

    func toggleFavorite(for id: Int) {
        fatalError("dummy double")
    }
}
