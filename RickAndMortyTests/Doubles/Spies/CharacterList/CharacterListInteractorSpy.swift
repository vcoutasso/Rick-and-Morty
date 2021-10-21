//
//  CharacterListInteractorSpy.swift
//  RickAndMortyTests
//
//  Created by Vinícius Couto on 21/10/21.
//

import XCTest
@testable import RickAndMorty

final class CharacterListInteractorSpy: CharacterListInteractorProtocol {
    var presenter: CharacterListPresenterProtocol
    var characters: [RMCharacter]?

    init(presenter: CharacterListPresenterProtocol) {
        self.presenter = presenter
    }

    private(set) var fetchDataCalled = false
    func fetchData(request: CharacterList.FetchData.Request) {
        fetchDataCalled = true
    }

    private(set) var filterDataCalled = false
    func filterData(request: CharacterList.FilterData.Request) {
        filterDataCalled = true
    }
}
