//
//  CharacterDetailScrollView.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 19/10/21.
//

import UIKit

class CharacterDetailScrollView: UIScrollView {

    // MARK: - Attributes

    var characterData: CharacterDetail.Character.ViewModel?

    // MARK: - Object lifecycle

    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        showsVerticalScrollIndicator = true
        backgroundColor = .systemPink
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func show() {
        setupImageView()
    }

    // MARK: - Setup

    private func setupImageView() {
        let imageView = characterData!.image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(imageView)

        let constraints = [
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: widthAnchor),
            imageView.heightAnchor.constraint(equalTo: heightAnchor),
        ]

        NSLayoutConstraint.activate(constraints)
    }

    // MARK: - Layout Metrics

    private enum LayoutMetrics {

    }
}
