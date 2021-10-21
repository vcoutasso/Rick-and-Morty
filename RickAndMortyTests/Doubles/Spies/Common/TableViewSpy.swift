//
//  TableViewSpy.swift
//  RickAndMortyTests
//
//  Created by Vinícius Couto on 21/10/21.
//

import XCTest
@testable import RickAndMorty

class TableViewSpy: UITableView {
    private(set) var reloadDataCalled = false
    override func reloadData() {
        reloadDataCalled = true
    }
}
