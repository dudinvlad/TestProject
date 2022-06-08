//
//  Style+Font.swift
//  SportViewer
//
//  Created by Vladislav Dudin on 06.05.2022.
//

import Foundation
import UIKit

extension Style.Font {

    enum FontName: String {
        case regular = "YouthTouchDEMO-Regular"
    }

    static let regularNormal = regular(size: 40)

    // MARK: - Private

    private static func regular(size: CGFloat) -> UIFont {
        makeFont(.regular, size)
    }

    private static func customizeNumbers(in font: UIFont, size: CGFloat) -> UIFont {
        let numberUppercaseAttributes = [
            UIFontDescriptor.FeatureKey.featureIdentifier: kNumberCaseType,
            UIFontDescriptor.FeatureKey.typeIdentifier: kUpperCaseNumbersSelector
        ]
        let newDescriptor = font.fontDescriptor.addingAttributes([
            .featureSettings: numberUppercaseAttributes
        ])
        return UIFont(descriptor: newDescriptor, size: size)
    }

    private static func makeFont(_ name: FontName, _ size: CGFloat) -> UIFont {
        if let font = UIFont(name: name.rawValue, size: size) {
            return customizeNumbers(in: font, size: size)
        } else {
            return .systemFont(ofSize: size, weight: .regular)
        }
    }

}
