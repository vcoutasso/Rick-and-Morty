//
//  CharacterDetailScrollView.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 19/10/21.
//

import UIKit

class CharacterDetailScrollView: UIView {

    // MARK: - Attributes

    var characterData: CharacterDetail.Character.ViewModel?
    private let imageClient = RMImageClient()

    // MARK: - Lazy views

    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.downloadRMImage(client: imageClient, from: characterData!.imageLink) {
            imageView.setNeedsDisplay()
        }
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.applyBlurEffect(style: .light)

        return imageView
    }()

    private lazy var backgroundSpacerView: UIView = {
        let spacer = UIView()
        spacer.translatesAutoresizingMaskIntoConstraints = false

        return spacer
    }()

    private lazy var cardView: UIView = {
        let card = UIView()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.backgroundColor = .systemBackground
        card.layer.cornerRadius = LayoutMetrics.cardCornerRadius

        return card
    }()

    private lazy var characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.downloadRMImage(client: imageClient, from: characterData!.imageLink) {
            imageView.setNeedsDisplay()
        }
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = LayoutMetrics.imageCornerRadius
        imageView.clipsToBounds = true

        return imageView
    }()

    private lazy var nameLabelView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = characterData!.name
        label.font = .preferredFont(for: .title2, weight: .bold)

        return label
    }()

    // MARK: - Object lifecycle

    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: - Setup

    func setup() {
        setupBackgroundView()
        setupCardView()
        setupCharacterImageView()
        setupNameLabelView()
    }

    private func setupBackgroundView() {
        addSubview(backgroundImageView)
        addSubview(backgroundSpacerView)

        let imageConstraints = [
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.widthAnchor.constraint(equalTo: widthAnchor),
            backgroundImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: LayoutMetrics.backgroundHeightMultiplier),
        ]

        let spacerConstraints = [
            backgroundSpacerView.topAnchor.constraint(equalTo: backgroundImageView.bottomAnchor),
            backgroundSpacerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundSpacerView.widthAnchor.constraint(equalTo: widthAnchor),
            backgroundSpacerView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ]

        NSLayoutConstraint.activate(imageConstraints)
        NSLayoutConstraint.activate(spacerConstraints)
    }

    private func setupCardView() {
        addSubview(cardView)

        let constraints = [
            cardView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: LayoutMetrics.cardHeightMultiplier),
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ]

        NSLayoutConstraint.activate(constraints)
    }

    private func setupCharacterImageView() {
        addSubview(characterImageView)

        let constraints = [
            characterImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            characterImageView.centerYAnchor.constraint(equalTo: cardView.topAnchor),
            characterImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: LayoutMetrics.imageHeightMultiplier),
            characterImageView.widthAnchor.constraint(equalTo: characterImageView.heightAnchor),
        ]

        NSLayoutConstraint.activate(constraints)
    }

    private func setupNameLabelView() {
        addSubview(nameLabelView)

        let constraints = [
            nameLabelView.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameLabelView.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: LayoutMetrics.imageToNameSeparator),
        ]


        NSLayoutConstraint.activate(constraints)
    }

    // MARK: - Layout Metrics

    private enum LayoutMetrics {
        static let backgroundHeightMultiplier: CGFloat = 0.5
        static let imageHeightMultiplier: CGFloat = 0.2
        static let cardHeightMultiplier: CGFloat = 0.8
        static let cardCornerRadius: CGFloat = 20
        static let imageCornerRadius: CGFloat = 8
        static let imageToNameSeparator: CGFloat = 5
    }
}
