//
//  CharacterListViewCellTitle.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 15/10/21.
//

import UIKit

class CharacterListViewCellTitle: UIStackView {

    // MARK: - Subviews

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.textColor = .label
        label.numberOfLines = 0
        label.font = .preferredFont(for: .title3, weight: .semibold)
        label.adjustsFontForContentSizeCategory = true

        return label
    }()

    private let statusDot: UIImageView = {
        let imageView = UIImageView()
        let configuration = UIImage.SymbolConfiguration(font: .preferredFont(forTextStyle: .caption2), scale: LayoutMetrics.symbolFontScale)
        imageView.image = UIImage(systemName: "circle.fill", withConfiguration: configuration)?
            .withTintColor(.gray, renderingMode: .alwaysOriginal)
        imageView.contentMode = .left

        return imageView
    }()

    private let aboutLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .footnote)
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

    func setup(with character: RMCharacter) {
        nameLabel.text = character.name
        aboutLabel.text = "\(character.status) - \(character.species)"

        switch character.status {
        case RMCharacter.StatusValues.alive.rawValue:
            statusDot.image = statusDot.image?.withTintColor(.green)
        case RMCharacter.StatusValues.dead.rawValue:
            statusDot.image = statusDot.image?.withTintColor(.red)
        case RMCharacter.StatusValues.unknown.rawValue:
            statusDot.image = statusDot.image?.withTintColor(.gray)
        default:
            print("Got unexpected character status value \(character.status)")
        }
    }

    // MARK: - Layout Metrics

    private enum LayoutMetrics {
        static let symbolFontScale: UIImage.SymbolScale = .small
        static let symbolToTextSpacing: CGFloat = 3
    }
}
