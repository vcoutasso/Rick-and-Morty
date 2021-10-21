//
//  CharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 17/10/21.
//

import UIKit

protocol CharacterDetailDisplayLogic: AnyObject {
    func displayDetailView(viewModel: CharacterDetail.Character.ViewModel)
    func displayFavoriteButton(viewModel: CharacterDetail.Favorite.ViewModel)
}

class CharacterDetailViewController: UIViewController, CharacterDetailDisplayLogic {
    var interactor: CharacterDetailInteractorProtocol
    var router:  CharacterDetailRouterProtocol

    private lazy var detailView = CharacterDetailView()

    // MARK: Object lifecycle

    init(interactor: CharacterDetailInteractorProtocol,
         router: CharacterDetailRouterProtocol) {
        self.interactor = interactor
        self.router = router

        super.init(nibName: nil, bundle: nil)

        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Setup

    private func setup() {
        interactor.presenter.viewController = self
        router.viewController = self
    }

    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        setupRouting()
    }

    private func setupView() {
        view.backgroundColor = .systemBackground

        view.addSubview(detailView)

        let constraints = [
            detailView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            detailView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            detailView.topAnchor.constraint(equalTo: view.topAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            detailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ]

        NSLayoutConstraint.activate(constraints)
    }


    // MARK: - Handle events

    @objc func handleFavoriteTapped() {
        setFavoriteButton()
    }

    // MARK: Routing

    func setupRouting() {
        router.setup()
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupRouting()
        setupView()
        getCharacter()
        getFavoriteButton()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.rightBarButtonItems = nil
    }

    // MARK: Get character

    func getCharacter() {
        let dataStore = router.dataStore
        let request = CharacterDetail.Character.Request(character: dataStore.character)
        interactor.getCharacter(request: request)
    }

    // MARK: - Set favorite

    func setFavoriteButton() {
        let request = CharacterDetail.Favorite.Request(characterID: router.dataStore.character.id)
        interactor.setFavorite(request: request)
    }

    // MARK: - Get favorite

    func getFavoriteButton() {
        let request = CharacterDetail.Favorite.Request(characterID: router.dataStore.character.id)
        interactor.getFavorite(request: request)
    }
    
    // MARK: - Display

    func displayDetailView(viewModel: CharacterDetail.Character.ViewModel) {
        detailView.characterData = viewModel
        detailView.setup()
    }

    func displayFavoriteButton(viewModel: CharacterDetail.Favorite.ViewModel) {
        let image = viewModel.image
        navigationItem.rightBarButtonItem?.image = image
    }
}
