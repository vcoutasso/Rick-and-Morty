//
//  CharacterTableViewCellTitle.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 15/10/21.
//

import UIKit

class CharacterTableViewCellTitle: UIStackView {

    // MARK: - Lazy views

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.textColor = .black
        label.font = .systemFont(ofSize: LayoutMetrics.nameFontSize, weight: .heavy)

        return label
    }()

    private lazy var aboutLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.textColor = .black
        label.font = .systemFont(ofSize: LayoutMetrics.statusFontSize, weight: .medium)

        return label
    }()

    // MARK: - Object lifecycle

    convenience init() {
        self.init(frame: .zero)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        translatesAutoresizingMaskIntoConstraints = false
        axis = .vertical

        addArrangedSubview(nameLabel)
        addArrangedSubview(aboutLabel)
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    func setup(with character: CharacterTable.Character) {
        nameLabel.text = character.name
        aboutLabel.text = "\(character.status) - \(character.species)"
    }

    // MARK: - Layout Metrics

    private enum LayoutMetrics {
        static let nameFontSize: CGFloat = 22
        static let statusFontSize: CGFloat = 18
    }

}
