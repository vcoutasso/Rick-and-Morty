//
//  CharacterDetailRouter.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 17/10/21.
//

import UIKit

@objc protocol CharacterDetailRoutingLogic {
    func setup()
}

protocol CharacterDetailDataPassing {
    var dataStore: CharacterDetailDataStore? { get }
}

class CharacterDetailRouter: NSObject, CharacterDetailRoutingLogic, CharacterDetailDataPassing {
    weak var viewController: CharacterDetailViewController?
    var dataStore: CharacterDetailDataStore?

    // MARK: - Setup

    func setup() {
        guard let viewController = viewController else { return }
        viewController.navigationItem.largeTitleDisplayMode = .never
        viewController.navigationItem.searchController = nil
    }

    // MARK: - Routing

    // MARK: - Navigation

    // MARK: - Passing data
}
