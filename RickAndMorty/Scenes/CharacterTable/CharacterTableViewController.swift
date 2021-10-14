//
//  CharacterTableViewController.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 14/10/21.
//

import UIKit

protocol CharacterTableDisplayLogic: AnyObject {

}

class CharacterTableViewController: UITableViewController, CharacterTableDisplayLogic {

    var interactor: CharacterTableBusinessLogic?
    var router: (NSObject & CharacterTableRoutingLogic & CharacterTableDataPassing)?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(CharacterTableViewCell.self)
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.defaultReuseIdentifier) as? CharacterTableViewCell else {
            return CharacterTableViewCell()
        }

        cell.setup()

        return cell
    }

    // TODO: A header view would probably be a better fit 
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Character List"
    }
}
