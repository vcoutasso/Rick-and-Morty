//
//  CharacterTableViewCellInfo.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 15/10/21.
//

import UIKit

class CharacterTableViewCellInfo: UIStackView {

    // MARK: - Attributes

    var title: String

    // MARK: - Subviews

    private lazy var infoTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.textColor = .secondaryLabel
        label.text = title
        label.font = .preferredFont(forTextStyle: .caption2)
        label.adjustsFontForContentSizeCategory = true

        return label
    }()

    private let infoContentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .footnote)
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
