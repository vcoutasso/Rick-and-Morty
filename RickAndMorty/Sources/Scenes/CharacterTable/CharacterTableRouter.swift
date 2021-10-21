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
    var dataStore: CharacterTableDataStore { get }
}

protocol CharacterTableRouterProtocol: CharacterTableRoutingLogic, CharacterTableDataPassing {
    var viewController: CharacterTableViewController? { get set }
}

class CharacterTableRouter: CharacterTableRouterProtocol {
    weak var viewController: CharacterTableViewController?
    var dataStore: CharacterTableDataStore

    // MARK: - Object lifecycle

    init(dataStore: CharacterTableDataStore) {
        self.dataStore = dataStore
    }

    // MARK: - Setup

    func setup() {
        guard let viewController = viewController, let navigationController = viewController.navigationController else { return }
        viewController.navigationItem.searchController = viewController.searchController
        viewController.navigationItem.hidesSearchBarWhenScrolling = false
        navigationController.navigationBar.prefersLargeTitles = true
    }

    // MARK: - Routing

    func routeToCharacterDetail() {
        let detailPresenter = CharacterDetailPresenter()
        let favoriteWorker = FavoriteCharacterWorker()
        let detailInteractor = CharacterDetailInteractor(presenter: detailPresenter, worker: favoriteWorker)
        let detailRouter = CharacterDetailRouter(dataStore: detailInteractor)

        let destinationVC = CharacterDetailViewController(interactor: detailInteractor, router: detailRouter)
        var destinationDS = destinationVC.router.dataStore

        passDataToCharacterDetail(source: dataStore, destination: &destinationDS)
        navigateToCharacterDetail(source: viewController!, destination: destinationVC)
    }

    // MARK: - Navigation

    func navigateToCharacterDetail(source: CharacterTableViewController, destination: CharacterDetailViewController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }

    // MARK: - Passing data

    // TODO: Too messy, clean this up
    func passDataToCharacterDetail(source: CharacterTableDataStore, destination: inout CharacterDetailDataStore) {
        let selectedIndexPath = viewController?.tableView.indexPathForSelectedRow
        let cell = viewController?.tableView.cellForRow(at: selectedIndexPath!) as! CharacterTableViewCell
        let selectedCharacter = cell.character!
        destination.character = source.characters?.first { $0.id == selectedCharacter.id }
    }
}
