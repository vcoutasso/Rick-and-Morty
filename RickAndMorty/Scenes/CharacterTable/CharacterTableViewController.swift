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
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setup() {
        let interactor = CharacterTableInteractor()
        let presenter = CharacterTablePresenter()
        let router = CharacterTableRouter()

        interactor.presenter = presenter
        presenter.viewController = self
        router.viewController = self
        router.dataStore = interactor
        self.interactor = interactor
        self.router = router
    }

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(CharacterTableViewCell.self)

        fetchCharacters()
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

        cell.setup(with: characters[indexPath.row])

        return cell
    }
    
    // TODO: A header view would probably be a better fit 
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Character List"
    }
}
