//
//  CoreDataStoreSpy.swift
//  RickAndMortyTests
//
//  Created by Vinícius Couto on 21/10/21.
//

import XCTest
import CoreData
@testable import RickAndMorty

final class CoreDataStoreSpy: CoreDataStoreProtocol {
    var context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    var fetchFavoritedStatusStub: Bool = .random()
    private(set) var fetchFavoritedStatusCalled = false
    func fetchFavoritedStatus(for id: Int) -> Bool {
        fetchFavoritedStatusCalled = true
        return fetchFavoritedStatusStub
    }

    private(set) var addFavoriteCalled = false
    func addFavorite(id: Int) {
        addFavoriteCalled = true
    }

    private(set) var removeFavoriteCalled = false
    func removeFavorite(id: Int) {
        removeFavoriteCalled = true
    }
}
