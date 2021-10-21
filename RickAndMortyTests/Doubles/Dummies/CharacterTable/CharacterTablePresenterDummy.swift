//
//  CharacterTablePresenterDummy.swift
//  RickAndMortyTests
//
//  Created by Vinícius Couto on 21/10/21.
//

import XCTest
@testable import RickAndMorty

final class CharacterTablePresenterDummy: CharacterTablePresenterProtocol {
    var viewController: CharacterTableDisplayLogic?

    func presentFetchedData(response: CharacterTable.FetchData.Response) {
        fatalError("dummy double")
    }

    func presentFilteredData(response: CharacterTable.FilterData.Response) {
        fatalError("dummy double")
    }
}
