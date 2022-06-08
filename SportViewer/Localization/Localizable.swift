//
//  Localizable.swift
//  SportViewer
//
//  Created by Vladislav Dudin on 06.05.2022.
//

import Foundation

protocol Localizable {
    var tableName: String { get }
    var localized: String { get }
}

extension Localizable where Self: RawRepresentable, Self.RawValue == String {
    var tableName: String {
        String(describing: Self.self)
    }

    var localized: String {
        rawValue.localized(tableName: tableName)
    }
}

private extension String {
    func localized(tableName: String) -> String {
        NSLocalizedString(self, tableName: tableName, comment: "")
    }
}
