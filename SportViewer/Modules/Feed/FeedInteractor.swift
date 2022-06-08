//
//  FeedInteractor.swift
//  SportViewer
//
//  Created Vladislav Dudin on 06.05.2022.
//

import UIKit

private typealias Module = FeedModule
private typealias Interactor = Module.Interactor

extension Module {
    final class Interactor {
        // MARK: - Dependencies

        weak var output: InteractorOutput!
        private let feedSevice: FeedService!

        required init(_ feedService: FeedService) {
            self.feedSevice = feedService
        }
    }
}

extension Interactor: Module.InteractorInput {
    func loadSportEvents() {
        feedSevice.getSportEvents { result in
            switch result {
            case .success(let events):
                self.output.receivedSportEvents(events)
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
}
