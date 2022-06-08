//
//  FeedAssembly.swift
//  SportViewer
//
//  Created Vladislav Dudin on 06.05.2022.
//

import UIKit
import Macaroni

private typealias Module = FeedModule
private typealias View = Module.ViewController

extension Module {
    final class ModuleAssembly: ModuleAssemblying {
        @Injected var feedService: FeedService!

        func assemble() -> UIViewController {
            let viewController: View   = .init()
            let presenter: Presenter   = .init()
            let interactor: Interactor = .init(feedService)
            let router: Router         = .init()

            
            viewController.output = presenter

            presenter.view       = viewController
            presenter.router     = router
            presenter.interactor = interactor

            interactor.output = presenter

            router.viewController = viewController

            return viewController
        }
    }
}
