//
//  CharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 17/10/21.
//

import UIKit

protocol CharacterDetailDisplayLogic: AnyObject {
    func displayDetailView(viewModel: CharacterDetail.Character.ViewModel)
}

class CharacterDetailViewController: UIViewController, CharacterDetailDisplayLogic {
    var interactor: CharacterDetailBusinessLogic?
    var router: (NSObjectProtocol & CharacterDetailRoutingLogic & CharacterDetailDataPassing)?

    private lazy var detailView = CharacterDetailScrollView()

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

    // MARK: Routing

    func setupRouting() {
    }

    // MARK: View lifecycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        doSomething()
    }

    // MARK: Do something

    func doSomething() {
        let dataStore = router!.dataStore!
        let request = CharacterDetail.Character.Request(character: dataStore.character)
        interactor?.doSomething(request: request)
    }

    func displayDetailView(viewModel: CharacterDetail.Character.ViewModel) {
        detailView.characterData = viewModel
        detailView.show()
    }
}
