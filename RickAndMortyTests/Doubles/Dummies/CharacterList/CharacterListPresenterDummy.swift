//
//  CharacterListPresenterDummy.swift
//  RickAndMortyTests
//
//  Created by Vinícius Couto on 21/10/21.
//

import XCTest
@testable import RickAndMorty

final class CharacterListPresenterDummy: CharacterListPresenterProtocol {
    var viewController: CharacterListDisplayLogic?

    func presentFetchedData(response: CharacterList.FetchData.Response) {
        fatalError("dummy double")
    }

    func presentFilteredData(response: CharacterList.FilterData.Response) {
        fatalError("dummy double")
    }
}
