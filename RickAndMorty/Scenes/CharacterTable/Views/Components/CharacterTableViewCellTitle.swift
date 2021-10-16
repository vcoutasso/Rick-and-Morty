//
//  CharacterTableViewCellTitle.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 15/10/21.
//

import UIKit

class CharacterTableViewCellTitle: UIStackView {

    // MARK: - Subviews

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.textColor = .black
        label.font = .preferredFont(for: .title2, weight: .heavy)
        label.adjustsFontForContentSizeCategory = true

        return label
    }()

    private let statusDot: UIImageView = {
        let imageView = UIImageView()
        let configuration = UIImage.SymbolConfiguration(font: .preferredFont(forTextStyle: .caption2))
        imageView.image = UIImage(systemName: "circle.fill", withConfiguration: configuration)?
            .withTintColor(.gray, renderingMode: .alwaysOriginal)
        imageView.contentMode = .left

        return imageView
    }()

    private let aboutLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.textColor = .black
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.adjustsFontForContentSizeCategory = true

        return label
    }()

    private lazy var aboutStackView: UIStackView = {
        let spacerView = UIView()
        let stack = UIStackView(arrangedSubviews: [statusDot, aboutLabel, spacerView])
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.contentMode = .left
        stack.alignment = .center
        stack.spacing = LayoutMetrics.symbolToTextSpacing

        return stack
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
        addArrangedSubview(aboutStackView)
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    func setup(with character: CharacterTable.Character) {
        nameLabel.text = character.name
        aboutLabel.text = "\(character.status) - \(character.species)"

        switch character.status {
        case CharacterTable.Character.StatusValues.alive.rawValue:
            statusDot.image = statusDot.image?.withTintColor(.green)
        case CharacterTable.Character.StatusValues.dead.rawValue:
            statusDot.image = statusDot.image?.withTintColor(.red)
        case CharacterTable.Character.StatusValues.unknown.rawValue:
            statusDot.image = statusDot.image?.withTintColor(.gray)
        default:
            print("Got unexpected character status value \(character.status)")
        }
    }

    // MARK: - Layout Metrics

    private enum LayoutMetrics {
        static let symbolFontSize: CGFloat = 8
        static let symbolToTextSpacing: CGFloat = 3
    }
}
