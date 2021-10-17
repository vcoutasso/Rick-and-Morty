//
//  CharacterTableViewController.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 14/10/21.
//

import UIKit

protocol CharacterTableDisplayLogic: AnyObject {
    func displayCharacters(viewModel: CharacterTable.FetchData.ViewModel)
}

class CharacterTableViewController: UITableViewController, CharacterTableDisplayLogic {
    // MARK: - Attributes

    private(set) var interactor: CharacterTableBusinessLogic?
    private(set) var router: (NSObject & CharacterTableRoutingLogic & CharacterTableDataPassing)?

    // MARK: - Table Data

    private(set) var characters = [CharacterTable.Character]()

    // MARK: - Object lifecycle

    init() {
        super.init(style: .plain)
        self.title = "Character List"

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setup() {
        let characterTableInteractor = CharacterTableInteractor()
        let characterTablePresenter = CharacterTablePresenter()
        let characterTableRouter = CharacterTableRouter()

        characterTableInteractor.presenter = characterTablePresenter
        characterTablePresenter.viewController = self
        characterTableRouter.viewController = self
        characterTableRouter.dataStore = characterTableInteractor

        interactor = characterTableInteractor
        router = characterTableRouter

    }

    // MARK: - View Lifecycle

    override func viewDidAppear(_ animated: Bool) {
        setupRouting()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(CharacterTableViewCell.self)

        fetchCharacters()
    }

    // MARK: - Routing

    func setupRouting() {
        guard let router = router else { return }
        router.setupNavigationBar()
    }

    // MARK: - Display logic

    func displayCharacters(viewModel: CharacterTable.FetchData.ViewModel) {
        characters = viewModel.characters

        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    // MARK: - Private methods

    private func fetchCharacters() {
        let request = CharacterTable.FetchData.Request(type: .all)
        interactor?.fetchData(request: request)
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.defaultReuseIdentifier) as? CharacterTableViewCell else {
            return CharacterTableViewCell()
        }

        cell.setup(with: self.characters[indexPath.row])

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
