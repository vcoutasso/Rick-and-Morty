//
//  CharacterDetailRouter.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 17/10/21.
//

import UIKit

protocol CharacterDetailRoutingLogic {
    func setup()
}

protocol CharacterDetailDataPassing {
    var dataStore: CharacterDetailDataStore { get }
}

protocol CharacterDetailRouterProtocol: CharacterDetailRoutingLogic, CharacterDetailDataPassing {
    var viewController: CharacterDetailViewController? { set get }
}

class CharacterDetailRouter: CharacterDetailRouterProtocol {
    weak var viewController: CharacterDetailViewController?
    var dataStore: CharacterDetailDataStore

    init(dataStore: CharacterDetailDataStore) {
        self.dataStore = dataStore
    }

    // MARK: - Setup

    func setup() {
        guard let viewController = viewController else { return }
        viewController.navigationItem.largeTitleDisplayMode = .never
        viewController.navigationItem.searchController = nil
        let rightBarButton = UIBarButtonItem(image: UIImage(), style: .plain, target: viewController, action: #selector(viewController.handleFavoriteTapped))
        viewController.navigationItem.setRightBarButton(rightBarButton, animated: true)
    }

    // MARK: - Routing

    // MARK: - Navigation

    // MARK: - Passing data
}
