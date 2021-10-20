//
//  CharacterDetailInfoView.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 15/10/21.
//

import UIKit

class CharacterDetailInfoView: UIStackView {

    // MARK: - Attributes

    var title: String

    // MARK: - Subviews

    private lazy var infoTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.textColor = .secondaryLabel
        label.text = title
        label.font = .preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true

        return label
    }()

    private let infoContentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true

        return label
    }()


    // MARK: - Object lifecycle

    init(title: String) {
        self.title = title

        super.init(frame: .zero)

        translatesAutoresizingMaskIntoConstraints = false
        axis = .vertical

        addArrangedSubview(infoTitleLabel)
        addArrangedSubview(infoContentLabel)
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    func setup(with content: String) {
        infoContentLabel.text = content
    }

    // MARK: - Layout Metrics

    private enum LayoutMetrics {
        static let titleFontSize: CGFloat = 11
        static let contentFontSize: CGFloat = 13
    }

}
