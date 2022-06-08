//
//  BaseViewController.swift
//  SportViewer
//
//  Created by Vladislav Dudin on 06.05.2022.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        initialSetup()
    }

    // MARK: - Private

    private func initialSetup() {
        view.backgroundColor = Style.Color.mainBackgroundColor

        setupNavigationTitle()
    }

    private func setupNavigationTitle() {
        self.title = FeedModule.Localize.feedNavigationBarTitle.localized
    }
}
