//
//  FavoriteCharacterWorker.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 20/10/21.
//

import UIKit

protocol FavoriteCharacterWorkerProtocol {
    func getFavoritedStatus(for id: Int) -> Bool
    func toggleFavorite(for id: Int)
}

class FavoriteCharacterWorker: FavoriteCharacterWorkerProtocol {
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private lazy var dataStore = CoreDataStore(context: context)

    func getFavoritedStatus(for id: Int) -> Bool {
        dataStore.fetchFavoritedStatus(for: id)
    }

    func toggleFavorite(for id: Int) {
        let isFavorite = getFavoritedStatus(for: id)

        if isFavorite {
            dataStore.removeFavorite(id: id)
        } else {
            dataStore.addFavorite(id: id)
        }
    }
}
