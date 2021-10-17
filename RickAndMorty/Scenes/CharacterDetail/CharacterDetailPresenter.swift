//
//  CharacterDetailPresenter.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 17/10/21.
//

import UIKit

protocol CharacterDetailPresentationLogic {
    func presentSomething(response: CharacterDetail.Something.Response)
}

class CharacterDetailPresenter: CharacterDetailPresentationLogic {
    weak var viewController: CharacterDetailDisplayLogic?

    // MARK: Do something

    func presentSomething(response: CharacterDetail.Something.Response) {
        let viewModel = CharacterDetail.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
