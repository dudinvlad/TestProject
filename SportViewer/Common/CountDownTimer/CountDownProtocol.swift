//
//  CountDownProtocol.swift
//  SportViewer
//
//  Created by Vladislav Dudin on 08.05.2022.
//

import Foundation

public typealias CompletionHandler = () -> Void

protocol CountDownable {

    var timeElapsed: TimeInterval { get set }
    var timeLimit: TimeInterval { get set }
    var isFinished: Bool { get }
    var isRunning: Bool { get }
    var completion: CompletionHandler? { get set }
    var repeatingTask: CompletionHandler? { get set }

    func start()
    func stop()
    func reset()
}
