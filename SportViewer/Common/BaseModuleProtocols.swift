//
//  BaseModuleProtocols.swift
//  SportViewer
//
//  Created by Vladislav Dudin on 06.05.2022.
//

import UIKit

protocol BaseViewInput: AnyObject {
}

protocol BaseViewOutput: AnyObject {
    func didLoad()
    func didAppear()
    func didDisappear()
    func willAppear()
    func willDisappear()
}

protocol BaseInteractorOutput: AnyObject {
    var controller: BaseViewInput? { get }

//    func failureNetworking(text: String)
//    func infoNetworking(text: String)
}

protocol BaseInteractor { }

extension BaseViewOutput {
    func didLoad() {}
    func didAppear() {}
    func didDisappear() {}
    func willAppear() {}
    func willDisappear() {}
}
