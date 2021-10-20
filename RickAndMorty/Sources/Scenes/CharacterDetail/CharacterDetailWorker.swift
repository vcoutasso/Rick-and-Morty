//
//  CharacterDetailWorker.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 17/10/21.
//

import UIKit
import CoreData

protocol CharacterDetailWorkerProtocol {
    func fetchFavoritedStatus(for id: Int) -> Bool
    func addFavorite(id: Int)
    func removeFavorite(id: Int)
}

class CharacterDetailWorker: CharacterDetailWorkerProtocol {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    func fetchFavoritedStatus(for id: Int) -> Bool {
        getFavoriteCharacter(for: id) != nil
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
            let request = FavoriteCharacter.fetchRequest() as NSFetchRequest<FavoriteCharacter>

            let pred = NSPredicate(format: "characterID == %d", id)
            request.predicate = pred

            return try context.fetch(request).first
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
