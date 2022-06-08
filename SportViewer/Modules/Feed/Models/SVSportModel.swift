//
//  SVSportModel.swift
//  SportViewer
//
//  Created by Vladislav Dudin on 07.05.2022.
//

import Foundation

class SVSportModel: Decodable {
    let id: String
    let name: String
    let event: [SVSportEventModel]

    enum CodingKeys: String, CodingKey {
        case id = "i"
        case name = "d"
        case event = "e"
    }
}

class SVSportEventModel: Decodable {
    let id: String
    let sportId: String
    let name: String
    let startTime: Date

    enum CodingKeys: String, CodingKey {
        case id = "i"
        case sportId = "si"
        case name = "d"
        case startTime = "tt"
    }

    var firstParticipant: String {
        let firstParticipant = name.components(separatedBy: "-").first
        return firstParticipant?.trimmingCharacters(in: .whitespacesAndNewlines) ?? String()
    }

    var secondParticipant: String {
        let secondParticipant = name.components(separatedBy: "-").last
        return secondParticipant?.trimmingCharacters(in: .whitespacesAndNewlines) ?? String()
    }

    var startTimeDescription: String {
        startTime.compare(Date()) == .orderedAscending ? FeedModule.Localize.feedFinishedEventTitle.localized : ""
    }

    var isFavourite: Bool = false
}
