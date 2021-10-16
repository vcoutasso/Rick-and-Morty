//
//  UIFont+.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 16/10/21.
//

import UIKit

extension UIFont {
    // Reference: https://stackoverflow.com/a/62687023
    static func preferredFont(for style: TextStyle, weight: Weight) -> UIFont {
        let traits = UITraitCollection(preferredContentSizeCategory: .large)
        let descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: style, compatibleWith: traits)

        let font: UIFont = .systemFont(ofSize: descriptor.pointSize, weight: weight)
        
        let metrics = UIFontMetrics(forTextStyle: style)

        return metrics.scaledFont(for: font)
    }
}
