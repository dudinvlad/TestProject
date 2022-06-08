//
//  FeedRouter.swift
//  SportViewer
//
//  Created Vladislav Dudin on 06.05.2022.
//

import UIKit

private typealias Module = FeedModule
private typealias Router = Module.Router

extension Module {
    final class Router {
        // MARK: - Dependencies

        weak var viewController: UIViewController!

        required init() { }
    }
}

extension Router: Module.RouterInput { }
