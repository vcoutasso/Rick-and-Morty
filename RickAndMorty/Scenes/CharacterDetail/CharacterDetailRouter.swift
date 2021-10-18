//
//  CharacterDetailRouter.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 17/10/21.
//

import UIKit

@objc protocol CharacterDetailRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol CharacterDetailDataPassing {
    var dataStore: CharacterDetailDataStore? { get }
}

class CharacterDetailRouter: NSObject, CharacterDetailRoutingLogic, CharacterDetailDataPassing {
    weak var viewController: CharacterDetailViewController?
    var dataStore: CharacterDetailDataStore?

    // MARK: Routing

    //func routeToSomewhere(segue: UIStoryboardSegue?)
    //{
    //  if let segue = segue {
    //    let destinationVC = segue.destination as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //  } else {
    //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //    navigateToSomewhere(source: viewController!, destination: destinationVC)
    //  }
    //}

    // MARK: Navigation

    //func navigateToSomewhere(source: CharacterDetailViewController, destination: SomewhereViewController)
    //{
    //  source.show(destination, sender: nil)
    //}

    // MARK: Passing data

    //func passDataToSomewhere(source: CharacterDetailDataStore, destination: inout SomewhereDataStore)
    //{
    //  destination.name = source.name
    //}
}
