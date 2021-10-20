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
    var interactor: CharacterDetailBusinessLogic?
    var router: (NSObjectProtocol & CharacterDetailRoutingLogic & CharacterDetailDataPassing)?

    private lazy var detailView = CharacterDetailView()

    // MARK: Object lifecycle

    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Setup

    private func setup() {
        let viewController = self
        let characterDetailInteractor = CharacterDetailInteractor()
        let characterDetailPresenter = CharacterDetailPresenter()
        let characterDetailRouter = CharacterDetailRouter()

        characterDetailInteractor.presenter = characterDetailPresenter
        characterDetailPresenter.viewController = viewController
        characterDetailRouter.dataStore = characterDetailInteractor
        characterDetailRouter.viewController = viewController

        interactor = characterDetailInteractor
        router = characterDetailRouter
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

    func setupFavoriteButton() {
        let request = CharacterDetail.Favorite.Request(characterID: router!.dataStore!.character.id)
        interactor?.favoriteItem(request: request)
    }

    // MARK: - Handle events

    @objc func handleFavoriteTapped() {
        setupFavoriteButton()
    }

    // MARK: Routing

    func setupRouting() {
        router?.setup()
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupRouting()
        setupView()
        getCharacter()
        setupFavoriteButton()
    }

    // MARK: Get character

    func getCharacter() {
        let dataStore = router!.dataStore!
        let request = CharacterDetail.Character.Request(character: dataStore.character)
        interactor?.getCharacter(request: request)
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
