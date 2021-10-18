//
//  CharacterTableRouter.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 14/10/21.
//

import UIKit

protocol CharacterTableRoutingLogic {
    func setup()
    func routeToCharacterDetail()
}

protocol CharacterTableDataPassing {
    var dataStore: CharacterTableDataStore? { get }
}

class CharacterTableRouter: NSObject, CharacterTableRoutingLogic, CharacterTableDataPassing {
    weak var viewController: CharacterTableViewController?
    var dataStore: CharacterTableDataStore?

    var character: RMCharacter?

    // MARK: - Setup

    func setup() {
        guard let viewController = viewController, let navigationController = viewController.navigationController else { return }
        viewController.navigationItem.searchController = viewController.searchController
        viewController.navigationItem.hidesSearchBarWhenScrolling = false
        navigationController.navigationBar.prefersLargeTitles = true
    }

    // MARK: - Routing

    func routeToCharacterDetail() {
        let destinationVC = CharacterDetailViewController()
        var destinationDS = destinationVC.router!.dataStore!

        passDataToCharacterDetail(source: dataStore!, destination: &destinationDS)
        navigateToCharacterDetail(source: viewController!, destination: destinationVC)
    }

    // MARK: - Navigation

    func navigateToCharacterDetail(source: CharacterTableViewController, destination: CharacterDetailViewController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }


    // MARK: - Passing data

    func passDataToCharacterDetail(source: CharacterTableDataStore, destination: inout CharacterDetailDataStore) {
        let selectedRow = viewController?.tableView.indexPathForSelectedRow?.row
        destination.character = source.characters?[selectedRow!]
    }
}
