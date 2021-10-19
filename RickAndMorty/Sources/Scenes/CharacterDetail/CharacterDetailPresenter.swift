//
//  CharacterDetailPresenter.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 17/10/21.
//

import UIKit

protocol CharacterDetailPresentationLogic {
    func presentCharacterDetail(response: CharacterDetail.Character.Response)
}

class CharacterDetailPresenter: CharacterDetailPresentationLogic {
    weak var viewController: CharacterDetailDisplayLogic?

    // MARK: Do something

    func presentCharacterDetail(response: CharacterDetail.Character.Response) {
        let character = response.character
        let isFavorite = response.isFavorite
        let id = character.id
        let name = character.name
        let status = character.status
        let species = character.species
        let type = character.type
        let gender = character.gender
        let imageLink = character.image
        let image = UIImageView()

        image.downloadRMImage(client: RMImageClient(), from: imageLink) {
            let viewModel = CharacterDetail.Character.ViewModel(id: id, name: name, status: status, species: species, type: type, gender: gender, image: image, isFavorite: isFavorite)
            self.viewController?.displayDetailView(viewModel: viewModel)
        }
    }
}
