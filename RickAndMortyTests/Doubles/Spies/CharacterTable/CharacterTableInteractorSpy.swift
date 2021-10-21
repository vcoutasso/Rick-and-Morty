//
//  CharacterTableInteractorSpy.swift
//  RickAndMortyTests
//
//  Created by Vinícius Couto on 21/10/21.
//

import XCTest
@testable import RickAndMorty

final class CharacterTableInteractorSpy: CharacterTableInteractorProtocol {
    var presenter: CharacterTablePresenterProtocol
    var characters: [RMCharacter]?

    init(presenter: CharacterTablePresenterProtocol) {
        self.presenter = presenter
    }

    private(set) var fetchDataCalled = false
    func fetchData(request: CharacterTable.FetchData.Request) {
        fetchDataCalled = true
    }

    private(set) var filterDataCalled = false
    func filterData(request: CharacterTable.FilterData.Request) {
        filterDataCalled = true
    }
}
