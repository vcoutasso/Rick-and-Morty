//
//  CharacterTableViewCell.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 14/10/21.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {

    // MARK: - Attributes

    private(set) var character: CharacterTable.Character?

    // MARK: - Lazy views

    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    private lazy var nameLabelView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var infoStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal

        return stack
    }()

    // MARK: - Object lifecycle

    convenience init() {
        self.init(style: .default, reuseIdentifier: Self.defaultReuseIdentifier)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupContentView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    // TODO: Update tablevc when download finishes
    func setup(with character: CharacterTable.Character) {
        avatarImageView.downloaded(from: character.image)
    }

    private func setupContentView() {
        setupAvatarImageView()
        setupNameLabelView()
        setupInfoStackView()
    }

    private func setupAvatarImageView() {
        contentView.addSubview(avatarImageView)

        let constraints = [
            avatarImageView.heightAnchor.constraint(equalToConstant: LayoutMetrics.imageHeight).withPriority(.defaultHigh),
            avatarImageView.widthAnchor.constraint(equalToConstant: LayoutMetrics.imageHeight * LayoutMetrics.avatarAspectRatio),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: LayoutMetrics.topPadding),
            avatarImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: LayoutMetrics.bottomPadding),
        ]

        NSLayoutConstraint.activate(constraints)
    }

    private func setupNameLabelView() {
        contentView.addSubview(nameLabelView)

        NSLayoutConstraint.activate([
            // TODO: Constraints
        ])
    }

    private func setupInfoStackView() {
        contentView.addSubview(infoStackView)

        NSLayoutConstraint.activate([
            // TODO: Constraints
        ])
    }

    // MARK: - Layout Metrics

    private enum LayoutMetrics {
        static let leadingPadding: CGFloat = 16
        static let topPadding: CGFloat = 5
        static let bottomPadding: CGFloat = -5
        static let imageHeight: CGFloat = 80
        static let avatarAspectRatio: CGFloat = 4/3
    }
}

extension CharacterTableViewCell: ReusableView {}
