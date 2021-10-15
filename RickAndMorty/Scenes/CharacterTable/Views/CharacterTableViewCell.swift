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

    private lazy var statusSpeciesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.textColor = .black
        label.font = .systemFont(ofSize: 18, weight: .medium)

        return label
    }()

    private lazy var nameLabelView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.textColor = .black
        label.font = .systemFont(ofSize: LayoutMetrics.nameFontSize, weight: .heavy)

        return label
    }()

    private lazy var infoStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical

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

    func setup(with character: CharacterTable.Character) {
        avatarImageView.downloaded(from: character.image)

        nameLabelView.text = character.name
        statusSpeciesLabel.text = "\(character.status) - \(character.species)"
    }

    private func setupContentView() {
        setupAvatarImageView()
        setupInfoStackView()
    }

    private func setupAvatarImageView() {
        contentView.addSubview(avatarImageView)

        let constraints = [
            avatarImageView.heightAnchor.constraint(equalToConstant: LayoutMetrics.imageHeight).withPriority(.defaultHigh),
            avatarImageView.widthAnchor.constraint(lessThanOrEqualToConstant: LayoutMetrics.imageHeight * LayoutMetrics.avatarAspectRatio),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: LayoutMetrics.topPadding),
            avatarImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: LayoutMetrics.bottomPadding),
        ]

        NSLayoutConstraint.activate(constraints)
    }

    private func setupInfoStackView() {
        let stackView1 = UIStackView(arrangedSubviews: [nameLabelView, statusSpeciesLabel])
        stackView1.axis = .vertical

        infoStackView.addArrangedSubview(stackView1)

        contentView.addSubview(infoStackView)

        let constraints = [
            infoStackView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor),
            infoStackView.topAnchor.constraint(equalTo: avatarImageView.topAnchor, constant: LayoutMetrics.topPadding),
            infoStackView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: LayoutMetrics.bottomPadding),
            infoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ]

        NSLayoutConstraint.activate(constraints)
    }

    // MARK: - Layout Metrics

    private enum LayoutMetrics {
        static let leadingPadding: CGFloat = 14
        static let topPadding: CGFloat = 5
        static let bottomPadding: CGFloat = -5
        static let imageHeight: CGFloat = UIScreen.main.bounds.height / 8
        static let avatarAspectRatio: CGFloat = 4/3
        static let nameFontSize: CGFloat = 22
    }
}

extension CharacterTableViewCell: ReusableView {}
