//
//  CharacterListViewController.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 14/10/21.
//

import UIKit

protocol CharacterListDisplayLogic: AnyObject {
    func displayCharacters(viewModel: CharacterList.FetchData.ViewModel)
    func displaySearchResults(viewModel: CharacterList.FilterData.ViewModel)
}

class CharacterListViewController: UITableViewController, CharacterListDisplayLogic {
    // MARK: - Attributes

    private(set) var interactor: CharacterListInteractorProtocol
    private(set) var router: CharacterListRouterProtocol

    // MARK: - Table Data

    private(set) var characters = [[RMCharacter]]()
    private(set) var sections = [String]()

    private(set) lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.delegate = self

        return searchController
    }()

    // MARK: - Object lifecycle

    init(interactor: CharacterListInteractorProtocol, router: CharacterListRouterProtocol) {
        self.interactor = interactor
        self.router = router

        super.init(style: .plain)

        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setup() {
        title = "Character List"

        interactor.presenter.viewController = self
        router.viewController = self
    }

    private func setupTableView() {
        tableView.register(CharacterListViewCell.self)

        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(handlePullToRefresh), for: .valueChanged)
    }

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.accessibilityIdentifier = title

        setupTableView()
        fetchCharacters()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setupRouting()
    }

    // MARK: - Routing

    func setupRouting() {
        router.setup()
    }

    // MARK: - Display logic

    func displayCharacters(viewModel: CharacterList.FetchData.ViewModel) {
        characters = viewModel.characters
        sections = viewModel.sections

        reloadData(animated: false)
    }

    func displaySearchResults(viewModel: CharacterList.FilterData.ViewModel) {
        characters = viewModel.characters
        sections = viewModel.sections

        reloadData(animated: false)
    }

    // MARK: - Private methods

    private func fetchCharacters() {
        let request = CharacterList.FetchData.Request()
        interactor.fetchData(request: request)
    }

    // MARK: - Data source

    @objc func handlePullToRefresh() {
        refreshControl?.endRefreshing()
        reloadData(animated: true)
    }

    func reloadData(animated: Bool) {
        DispatchQueue.main.async {
            if animated {
                self.tableView.reloadData()
            } else {
                UIView.performWithoutAnimation {
                    self.tableView.reloadData()
                    self.tableView.beginUpdates()
                    self.tableView.endUpdates()
                }
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterListViewCell.defaultReuseIdentifier) as? CharacterListViewCell else {
            return CharacterListViewCell()
        }

        let selectedCharacter = characters[indexPath.section][indexPath.row]

        cell.setup(with: selectedCharacter)
        cell.accessibilityIdentifier = selectedCharacter.name

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router.routeToCharacterDetail()
    }

    // REVIEW: Needs refactoring. Also, needs testing
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let coreDataStore = CoreDataStore(context: managedObjectContext)

        let worker = FavoriteCharacterWorker(context: managedObjectContext, dataStore: coreDataStore)
        let id = characters[indexPath.section][indexPath.row].id
        
        let actionHandler: UIContextualAction.Handler = { action, view, completion in
            worker.toggleFavorite(for: id)
            completion(true)
        }

        let isFavorite = worker.getFavoritedStatus(for: id)
        let style: UIContextualAction.Style = isFavorite ? .destructive : .normal
        let title: String = isFavorite ? "Unfavorite" : "Favorite"
        let action = UIContextualAction(style: style, title: title, handler: actionHandler)

        if !isFavorite {
            action.backgroundColor = .systemGreen
        }

        return UISwipeActionsConfiguration(actions: [action])
    }
}

extension CharacterListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let request = CharacterList.FilterData.Request(searchText: searchText)
        interactor.filterData(request: request)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.searchBar.text = ""
        self.searchBar(searchBar, textDidChange: "")
    }
}
