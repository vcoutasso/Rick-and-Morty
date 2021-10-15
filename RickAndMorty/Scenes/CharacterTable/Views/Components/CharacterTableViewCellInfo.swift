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

    // MARK: - Lazy views

    private lazy var infoTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.textColor = .darkGray
        label.text = title
        label.font = .systemFont(ofSize: LayoutMetrics.titleFontSize, weight: .medium)

        return label
    }()

    private lazy var infoContentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.textColor = .black
        label.font = .systemFont(ofSize: LayoutMetrics.contentFontSize, weight: .medium)

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
