//
//  CharacterDetailWorker.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 17/10/21.
//

import UIKit

protocol CharacterDetailWorkerProtocol {
    func fetchFavoritedStatus(for id: Int) -> Bool
    func addFavorite(id: Int)
    func removeFavorite(id: Int)
}

class CharacterDetailWorker: CharacterDetailWorkerProtocol {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    func fetchFavoritedStatus(for id: Int) -> Bool {
        do {
            let favorites = try context.fetch(FavoriteCharacter.fetchRequest())
            return favorites.contains { $0.characterID == id}

        } catch {
            print(error)
        }

        return false
    }

    func addFavorite(id: Int) {
        let newFavorite = FavoriteCharacter(context: context)
        newFavorite.characterID = Int64(id)

        saveContext()
    }

    func removeFavorite(id: Int) {
        if let favoriteToRemove = getFavoriteCharacter(for: id) {
            context.delete(favoriteToRemove)

            saveContext()
        }
    }

    private func getFavoriteCharacter(for id: Int) -> FavoriteCharacter? {
        do {
            let favorites = try context.fetch(FavoriteCharacter.fetchRequest())
            return favorites.first { $0.characterID == Int64(id) }
        } catch {
            print(error)
        }

        return nil
    }

    private func saveContext() {
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
}
