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

    // MARK: - Lazy views

    private lazy var backgroundImageView: UIImageView = {
        let imageView = characterData!.image
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
    }

    private func setupBackgroundView() {
        addSubview(backgroundImageView)
        addSubview(backgroundSpacerView)

        let imageConstraints = [
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.widthAnchor.constraint(equalTo: widthAnchor),
            backgroundImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: LayoutMetrics.imageHeightMultiplier),
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

    // MARK: - Layout Metrics

    private enum LayoutMetrics {
        static let imageHeightMultiplier: CGFloat = 0.5
    }
}
