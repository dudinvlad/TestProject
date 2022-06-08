//
//  RestContainer.swift
//  SportViewer
//
//  Created by Vladislav Dudin on 07.05.2022.
//

import Macaroni

class RestContainer {
    // MARK: - Variables

    let baseUrl: String

    // MARK: - Lifecycle

    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }

    // MARK: - Feed

    private lazy var feedAssembly = FeedModule.ModuleAssembly()

    // MARK: - Services

    private lazy var networkManager = NetworkManager(baseURL: baseUrl)
    private lazy var feedService = RestFeedService(networkManager: networkManager)

    // MARK: - Public

    func build() -> Container {
        let container = Container()

        container.register { [feedAssembly] () -> FeedModule.ModuleAssemblying in feedAssembly }

        container.register { [feedService] () -> FeedService in feedService }

        return container
    }
}
