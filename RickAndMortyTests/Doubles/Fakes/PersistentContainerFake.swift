//
//  PersistentContainerFake.swift
//  RickAndMortyTests
//
//  Created by Vinícius Couto on 21/10/21.
//

import XCTest
import CoreData
@testable import RickAndMorty

final class PersistentContainerFake: NSObject {
    lazy var container: NSPersistentContainer = {
        let description = NSPersistentStoreDescription()
         description.url = URL(fileURLWithPath: "/dev/null")

         let container = NSPersistentContainer(name: "RickAndMorty")
         container.persistentStoreDescriptions = [description]
         container.loadPersistentStores { _, error in
             if let error = error as NSError? {
                 fatalError("Unresolved error \(error), \(error.userInfo)")
             }
         }

         return container
    }()
}
