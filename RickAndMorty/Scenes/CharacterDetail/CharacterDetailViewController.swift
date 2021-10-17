//
//  CharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 17/10/21.
//

import UIKit

protocol CharacterDetailDisplayLogic: AnyObject {
    func displaySomething(viewModel: CharacterDetail.Something.ViewModel)
}

class CharacterDetailViewController: UIViewController, CharacterDetailDisplayLogic {
    var interactor: CharacterDetailBusinessLogic?
    var router: (NSObjectProtocol & CharacterDetailRoutingLogic & CharacterDetailDataPassing)?

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
        let interactor = CharacterDetailInteractor()
        let presenter = CharacterDetailPresenter()
        let router = CharacterDetailRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: Routing

    // TODO: Implement routing

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        doSomething()
    }

    // MARK: Do something

    func doSomething() {
        let request = CharacterDetail.Something.Request()
        interactor?.doSomething(request: request)
    }

    func displaySomething(viewModel: CharacterDetail.Something.ViewModel) {
        //nameTextField.text = viewModel.name
    }
}
