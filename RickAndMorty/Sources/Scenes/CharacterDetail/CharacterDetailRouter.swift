//
//  CharacterDetailRouter.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 17/10/21.
//

import UIKit

@objc protocol CharacterDetailRoutingLogic {
}

protocol CharacterDetailDataPassing {
    var dataStore: CharacterDetailDataStore? { get }
}

class CharacterDetailRouter: NSObject, CharacterDetailRoutingLogic, CharacterDetailDataPassing {
    weak var viewController: CharacterDetailViewController?
    var dataStore: CharacterDetailDataStore?

    // MARK: - Setup

    // MARK: - Routing

    // MARK: - Navigation

    // MARK: - Passing data
}
