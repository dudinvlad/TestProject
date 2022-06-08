//
//  Applicable.swift
//  SportViewer
//
//  Created by Vladislav Dudin on 06.05.2022.
//

import UIKit

// MARK: - Applicable

protocol Applicable {
    associatedtype Applicant

    func apply(_ object: Applicant)
}

precedencegroup StylePrecedence {
    associativity: left
    higherThan: AdditionPrecedence
}

infix operator <~: StylePrecedence

@discardableResult
func <~<T: Applicable>(object: T.Applicant, applicable: T) -> T.Applicant {
    applicable.apply(object)
    return object
}

func <~ (string: String, attributes: [NSAttributedString.Key: Any]) -> NSAttributedString {
    NSAttributedString(string: string, attributes: attributes)
}

@discardableResult
func <~ (string: NSMutableAttributedString, attributes: [NSAttributedString.Key: Any]) -> NSMutableAttributedString {
    string.addAttributes(attributes, range: NSRange(location: .zero, length: string.length))
    return string
}

func <~ (attributesTo: [NSAttributedString.Key: Any], attributesFrom: [NSAttributedString.Key: Any]) -> [NSAttributedString.Key: Any] {
    var resultsAttributes = attributesTo
    attributesFrom.forEach { item in
        resultsAttributes[item.key] = item.value
    }
    return resultsAttributes
}

public func build<T>(_ object: T, builder: (T) -> Void) -> T {
    builder(object)
    return object
}

public func build<T: UIView>(builder: (T) -> Void) -> T {
    build(T(), builder: builder)
}

public func build<T: NSObject>(builder: (T) -> Void) -> T {
    build(T(), builder: builder)
}
