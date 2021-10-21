//
//  CoreDataStoreDummy.swift
//  RickAndMortyTests
//
//  Created by Vinícius Couto on 21/10/21.
//

import XCTest
import CoreData
@testable import RickAndMorty

final class CoreDataStoreDummy: CoreDataStoreProtocol {
    var context: NSManagedObjectContext

    init (context: NSManagedObjectContext) {
        self.context = context
    }

    func fetchFavoritedStatus(for id: Int) -> Bool {
        fatalError("dummy double")
    }

    func addFavorite(id: Int) {
        fatalError("dummy double")
    }

    func removeFavorite(id: Int) {
        fatalError("dummy double")
    }
}
