//
//  CharacterListViewController.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 14/10/21.
//

import UIKit

protocol CharacterListDisplayLogic: AnyObject {

}

class CharacterListViewController: UIViewController, CharacterListDisplayLogic {

    var interactor: CharacterListBusinessLogic?
    var router: (NSObject & CharacterListRoutingLogic & CharacterListDataPassing)?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemPink
    }

}

