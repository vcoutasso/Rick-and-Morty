//
//  FavoriteCharacterWorker.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 20/10/21.
//

import CoreData

protocol FavoriteCharacterWorkerProtocol {
    func getFavoritedStatus(for id: Int) -> Bool
    func toggleFavorite(for id: Int)
}

class FavoriteCharacterWorker: FavoriteCharacterWorkerProtocol {
    let context: NSManagedObjectContext
    let dataStore: CoreDataStoreProtocol

    // MARK: - Object lifecycle

    init(context: NSManagedObjectContext, dataStore: CoreDataStoreProtocol) {
        self.context = context
        self.dataStore = dataStore
    }

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
