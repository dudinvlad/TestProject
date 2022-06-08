//
//  FeedPresenter.swift
//  SportViewer
//
//  Created Vladislav Dudin on 06.05.2022.
//

import UIKit

private typealias Module = FeedModule
private typealias Presenter = Module.Presenter

extension Module {
    final class Presenter {
        // MARK: - Dependencies

        weak var view: ViewInput!
        var interactor: InteractorInput!
        var router: RouterInput!

        private var items: [SVSportModel] = .init()

        required init() { }

    }
}

private extension Presenter { }

extension Presenter: Module.ViewOutput {
    func getSportEvents() -> [SVSportModel] {
        items
    }

    func didLoad() {
        interactor.loadSportEvents()
    }
}

extension Presenter: Module.InteractorOutput {
    func receivedSportEvents(_ items: [SVSportModel]) {
        self.items = items
        self.view.eventsDidLoad()
    }

    var controller: BaseViewInput? {
        view
    }
}
