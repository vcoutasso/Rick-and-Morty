//
//  CharacterTableRouter.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 14/10/21.
//

import UIKit

protocol CharacterTableRoutingLogic {
    func setupNavigationBar()
}

protocol CharacterTableDataPassing {

}

class CharacterTableRouter: NSObject, CharacterTableRoutingLogic, CharacterTableDataPassing {
    weak var viewController: CharacterTableViewController?
    var dataStore: CharacterTableDataStore?

    // MARK: - Setup

    func setupNavigationBar() {
        guard let navigationController = viewController?.navigationController else { return }
        navigationController.navigationBar.prefersLargeTitles = true
    }

}
