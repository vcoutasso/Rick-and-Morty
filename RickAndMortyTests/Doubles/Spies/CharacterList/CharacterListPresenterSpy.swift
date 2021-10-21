//
//  CharacterListPresenterSpy.swift
//  RickAndMortyTests
//
//  Created by Vinícius Couto on 21/10/21.
//

import XCTest
@testable import RickAndMorty

final class CharacterListPresenterSpy: CharacterListPresenterProtocol {
    var viewController: CharacterListDisplayLogic?

    private(set) var presentCharactersDataCalled = false
    func presentFetchedData(response: CharacterList.FetchData.Response) {
        presentCharactersDataCalled = true
    }

    private(set) var presentFilteredDataCalled = false
    func presentFilteredData(response: CharacterList.FilterData.Response) {
        presentFilteredDataCalled = true
    }
}
