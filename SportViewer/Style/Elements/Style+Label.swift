//
//  Style+Label.swift
//  SportViewer
//
//  Created by Vladislav Dudin on 07.05.2022.
//

import UIKit

extension Style.Label {
    struct ColoredLabel: Applicable {
        var titleColor: UIColor
        var font: UIFont
        var numberOfLines: Int = 1
        var textAlignment: NSTextAlignment = .left

        func apply(_ object: UILabel) {
            object.textColor = titleColor
            object.font = font
            object.numberOfLines = numberOfLines
            object.textAlignment = textAlignment
        }
    }

    // MARK: - Public

    static let eventParticipantLabel = ColoredLabel(
        titleColor: .lightText,
        font: .systemFont(ofSize: 10),
        textAlignment: .center
    )

    static let sportNameLabel = ColoredLabel(
        titleColor: .white,
        font: .systemFont(
            ofSize: 15,
            weight: .medium
        )
    )

    static let eventTimeLabel = ColoredLabel(
        titleColor: .lightText,
        font: .systemFont(ofSize: 12),
        textAlignment: .center
    )
}
