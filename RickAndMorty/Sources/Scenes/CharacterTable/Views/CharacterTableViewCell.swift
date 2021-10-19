//
//  CharacterTableViewCell.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 14/10/21.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {

    // MARK: - Attributes

    private(set) var character: RMCharacter?

    private let imageCacheClient = RMImageClient()

    // MARK: - Subviews

    private let titleStackView: CharacterTableViewCellTitle = .init()
    private let spinner = UIActivityIndicatorView()
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .systemGray5

        return imageView
    }()
    private let locationInfo: CharacterTableViewCellInfo = .init(title: "Last known location:")
    private let genderInfo: CharacterTableViewCellInfo = .init(title: "Gender:")
    private let infoStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .equalCentering
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

    // MARK: - Table view cell

    override func prepareForReuse() {
        character = nil
        avatarImageView.image = nil
        avatarImageView.backgroundColor = .systemGray5
    }

    // MARK: - Setup

    func setup(with character: RMCharacter) {
        self.character = character
        avatarImageView.downloadRMImage(client: imageCacheClient, from: character.image) { [weak self] in
            self?.avatarImageView.backgroundColor = .clear
            self?.setNeedsDisplay()
        }
        titleStackView.setup(with: character)
        locationInfo.setup(with: character.location.name)
        genderInfo.setup(with: character.gender)
    }

    private func setupContentView() {
        setupAvatarImageView()
        setupInfoStackView()
    }

    private func setupAvatarImageView() {
        contentView.addSubview(avatarImageView)

        // FIXME: Image size should adjust with font size. The current approach works in many cases, but breaks when text is too large
        let constraints = [
            avatarImageView.heightAnchor.constraint(equalToConstant: LayoutMetrics.imageHeight).withPriority(.defaultHigh),
            avatarImageView.widthAnchor.constraint(equalToConstant: LayoutMetrics.imageHeight),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutMetrics.leadingPadding),
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: LayoutMetrics.topPadding),
            avatarImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: LayoutMetrics.bottomPadding),
        ]

        NSLayoutConstraint.activate(constraints)
    }

    private func setupInfoStackView() {
        infoStackView.addArrangedSubview(titleStackView)
        infoStackView.addArrangedSubview(locationInfo)
        infoStackView.addArrangedSubview(genderInfo)

        contentView.addSubview(infoStackView)

        let constraints = [
            infoStackView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: LayoutMetrics.imageToInfoPadding),
            infoStackView.topAnchor.constraint(equalTo: avatarImageView.topAnchor, constant: LayoutMetrics.topPadding),
            infoStackView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: LayoutMetrics.bottomPadding),
            infoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ]

        NSLayoutConstraint.activate(constraints)
    }

    // MARK: - Layout Metrics

    private enum LayoutMetrics {
        static let leadingPadding: CGFloat = 20
        static let topPadding: CGFloat = 5
        static let bottomPadding: CGFloat = -5
        static let imageHeight: CGFloat = UIScreen.main.bounds.height / 7
        static let imageToInfoPadding: CGFloat = 10
    }
}

extension CharacterTableViewCell: ReusableView {}
