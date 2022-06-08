//
//  Date+Format.swift
//  SportViewer
//
//  Created by Vladislav Dudin on 08.05.2022.
//

import Foundation

extension TimeInterval {
    private var milliseconds: Int {
        return Int((truncatingRemainder(dividingBy: 1)) * 1000)
    }

    private var seconds: Int {
        return Int(self) % 60
    }

    private var minutes: Int {
        return (Int(self) / 60 ) % 60
    }

    private var hours: Int {
        return Int(self) / 3600
    }

    var timeTillStart: String {
        if hours != .zero {
            return "\(hours)h:\(minutes)m:\(seconds)s"
        } else if minutes != 0 {
            return "00:\(minutes)m:\(seconds)s"
        } else {
            return "00:00:\(seconds)s"
        }
    }
}
