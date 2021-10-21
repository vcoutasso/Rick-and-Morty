//
//  CoreDataStore.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 20/10/21.
//

import CoreData

class CoreDataStore {
    let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    deinit {
        saveContext()
    }

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
            print("Error fetching from managed object context")
        }

        return nil
    }

    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Error saving managed object context")
        }
    }
}
