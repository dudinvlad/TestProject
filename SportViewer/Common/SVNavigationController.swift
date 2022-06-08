//
//  SVNavigationController.swift
//  SportViewer
//
//  Created by Vladislav Dudin on 06.05.2022.
//

import UIKit

final class SVNavigationController: UINavigationController {

    @available(iOS 13.0, *)
    private lazy var appearance: UINavigationBarAppearance = {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = Style.Color.navigationBarColor
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: Style.Font.regularNormal]
        return appearance
    }()


    // MARK: - Init

    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        self.configurate()
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    private func configurate() {
        navigationBar.isTranslucent = false

        if #available(iOS 13, *) {
            navigationBar.standardAppearance = appearance
            navigationBar.scrollEdgeAppearance = appearance
            navigationBar.compactAppearance = appearance
        } else {
            navigationBar.barTintColor = Style.Color.navigationBarColor
            navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: Style.Font.regularNormal]
        }

        modalPresentationStyle = .currentContext
    }
}
