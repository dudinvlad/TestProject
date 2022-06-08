//
//  SVCountdownTimer.swift
//  SportViewer
//
//  Created by Vladislav Dudin on 08.05.2022.
//

import Foundation
import QuartzCore

final class SVCountdownTimer: CountDownable {
    // MARK: - Variables

    var timeElapsed: TimeInterval {
        didSet {
            guard timeElapsed > .zero else { return }

            if timeLimit - timeElapsed <= .zero {
                stop()
            }
        }
    }

    var timeLimit: TimeInterval {
        didSet {
            reset()
        }
    }

    var isFinished: Bool {
        return timeLimit - timeElapsed <= .zero
    }

    var isRunning: Bool {
        return !(displayLink?.isPaused ?? true)
    }

    var completion: CompletionHandler?

    var repeatingTask: CompletionHandler?

    private weak var displayLink: CADisplayLink?
    private var lastExecutionTime: Date

    // MARK: - Lifecycle

    init(endsOn date: Date, repeatingTask: CompletionHandler?) {
        self.timeLimit = date.timeIntervalSinceNow
        self.repeatingTask = repeatingTask
        self.timeElapsed = .zero
        self.lastExecutionTime = Date()
    }

    deinit {
        displayLink?.invalidate()
        repeatingTask = nil
        completion = nil
    }

    // MARK: - Public

    func start() {
        self.lastExecutionTime = Date()
        let displayLink = CADisplayLink(target: self, selector: #selector(resetStats))
        displayLink.add(to: .current, forMode: .common)
        self.displayLink = displayLink
    }

    func stop() {
        displayLink?.invalidate()
    }

    func reset() {
        displayLink?.invalidate()
        timeElapsed = .zero
    }

    // MARK: - Private

    @objc private func resetStats() {
        guard !isFinished else { return }

        let currentDate = Date()
        let elapsedTime = currentDate.timeIntervalSince1970 - lastExecutionTime.timeIntervalSince1970
        self.timeElapsed += elapsedTime
        lastExecutionTime = currentDate
        repeatingTask?()
    }

}
