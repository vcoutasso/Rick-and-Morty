//
//  CharacterTablePresenterSpy.swift
//  RickAndMortyTests
//
//  Created by Vinícius Couto on 21/10/21.
//

import XCTest
@testable import RickAndMorty

final class CharacterTablePresenterSpy: CharacterTablePresenterProtocol {
    var viewController: CharacterTableDisplayLogic?

    private(set) var presentCharactersDataCalled = false
    func presentFetchedData(response: CharacterTable.FetchData.Response) {
        presentCharactersDataCalled = true
    }

    private(set) var presentFilteredDataCalled = false
    func presentFilteredData(response: CharacterTable.FilterData.Response) {
        presentFilteredDataCalled = true
    }
}
