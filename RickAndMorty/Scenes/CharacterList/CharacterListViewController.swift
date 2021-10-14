//
//  CharacterListViewController.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 14/10/21.
//

import UIKit

protocol CharacterListDisplayLogic: AnyObject {

}

class CharacterListViewController: UITableViewController, CharacterListDisplayLogic {

    var interactor: CharacterListBusinessLogic?
    var router: (NSObject & CharacterListRoutingLogic & CharacterListDataPassing)?

    // MARK: - Lazy views

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table View

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }

    // TODO: A header view would probably be a better fit 
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Character List"
    }
}
