//
//  CharacterTableViewController.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 14/10/21.
//

import UIKit

protocol CharacterTableDisplayLogic: AnyObject {
    func displayCharacters(viewModel: CharacterTable.FetchData.ViewModel)
    func displaySearchResults(viewModel: CharacterTable.FilterData.ViewModel)
}

class CharacterTableViewController: UITableViewController, CharacterTableDisplayLogic {
    // MARK: - Attributes

    private(set) var interactor: CharacterTableBusinessLogic?
    private(set) var router: (NSObjectProtocol & CharacterTableRoutingLogic & CharacterTableDataPassing)?

    // MARK: - Table Data

    private(set) var characters = [[RMCharacter]]()
    private(set) var sections = [String]()

    private(set) lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.delegate = self

        return searchController
    }()

    // MARK: - Object lifecycle

    init() {
        super.init(style: .plain)

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setup() {
        title = "Character List"

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
        router?.setup()
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
        sections = viewModel.sections

        reloadData(animated: true)
    }

    func displaySearchResults(viewModel: CharacterTable.FilterData.ViewModel) {
        characters = viewModel.characters
        sections = viewModel.sections

        reloadData(animated: false)
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
        reloadData(animated: true)
    }

    func reloadData(animated: Bool) {
        if animated {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } else {
            UIView.performWithoutAnimation {
                self.tableView.reloadData()
                self.tableView.beginUpdates()
                self.tableView.endUpdates()
            }
        }
    }

    // MARK: - Table View

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sections[section]
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }

    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        sections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.defaultReuseIdentifier) as? CharacterTableViewCell else {
            return CharacterTableViewCell()
        }

        cell.setup(with: characters[indexPath.section][indexPath.row])

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.routeToCharacterDetail()
    }
}

extension CharacterTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let interactor = interactor else { return }
        
        let request = CharacterTable.FilterData.Request(searchText: searchText)
        interactor.filterData(request: request)
    }
}