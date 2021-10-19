//
//  CharacterDetailModels.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 17/10/21.
//

import UIKit

enum CharacterDetail {
    // MARK: Use cases

    enum Character {
        struct Request {
            let character: RMCharacter
        }
        struct Response {
            let character: RMCharacter
            let isFavorite: Bool
        }
        struct ViewModel {
            let id: Int
            let name: String
            let status: String
            let species: String
            let type: String
            let gender: String
            let image: UIImageView
            var isFavorite = false
        }
    }
}
