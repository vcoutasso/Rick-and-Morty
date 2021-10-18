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
    private(set) var router: (NSObjectProtocol & CharacterTableRoutingLogic & CharacterTableDataPassing)?

    // MARK: - Table Data

    private(set) var characters = [RMCharacter]()

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
        characterTableRouter.dataStore = characterTableInteractor
        characterTableRouter.viewController = self

        interactor = characterTableInteractor
        router = characterTableRouter
    }

    private func setupTableView() {
        tableView.register(CharacterTableViewCell.self)

        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(handlePullToRefresh), for: .valueChanged)
    }

    // MARK: - Routing

    func setupRouting() {
        router?.setupNavigationBar()
    }

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupRouting()
        fetchCharacters()
    }


    // MARK: - Display logic

    func displayCharacters(viewModel: CharacterTable.FetchData.ViewModel) {
        characters = viewModel.characters

        reloadData()
    }

    // MARK: - Private methods

    private func fetchCharacters() {
        guard let interactor = interactor else { return }

        let request = CharacterTable.FetchData.Request()
        interactor.fetchData(request: request)
    }

    // MARK: - Data source

    @objc func handlePullToRefresh() {
        refreshControl?.endRefreshing()
        reloadData()
    }

    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
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
        router?.routeToCharacterDetail()
    }
}
