//
//  CharacterTableViewCell.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 14/10/21.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {

    // MARK: - Attributes

    var character: CharacterTable.Character?

    // MARK: - Lazy views

    // MARK: - Setup

    func setup(with character: CharacterTable.Character) {

    }
}

extension CharacterTableViewCell: ReusableView {}
