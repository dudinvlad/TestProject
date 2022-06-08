//
//  FeedModule.swift
//  SportViewer
//
//  Created Vladislav Dudin on 06.05.2022.
//

import UIKit

struct FeedModule {
    typealias ModuleAssemblying = FeedAssemblyProtocol
    typealias ViewInput         = FeedViewInputProtocol
    typealias ViewOutput        = FeedViewOutputProtocol
    typealias InteractorInput   = FeedInteractorInputProtocol
    typealias InteractorOutput  = FeedInteractorOutputProtocol
    typealias RouterInput       = FeedRouterInputProtocol

    enum Localize: String, Localizable {
        case feedNavigationBarTitle
        case feedFinishedEventTitle
    }
}

// MARK: - Assembly

protocol FeedAssemblyProtocol {
    func assemble() -> UIViewController
}

// MARK: - View
protocol FeedViewInputProtocol: BaseViewInput {
    func eventsDidLoad()
}

protocol FeedViewOutputProtocol: BaseViewOutput {
    func getSportEvents() -> [SVSportModel]
}

// MARK: - Interactor

protocol FeedInteractorInputProtocol {
    func loadSportEvents()
}

protocol FeedInteractorOutputProtocol: BaseInteractorOutput {
    func receivedSportEvents(_ items: [SVSportModel])
}

// MARK: - Router

protocol FeedRouterInputProtocol { }
