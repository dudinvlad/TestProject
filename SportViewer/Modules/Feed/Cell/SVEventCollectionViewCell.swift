//
//  SVEventCollectionViewCell.swift
//  SportViewer
//
//  Created by Vladislav Dudin on 07.05.2022.
//

import UIKit

class SVEventCollectionViewCell: UICollectionViewCell {

    // MARK: - Variables

    private lazy var containerStackView: UIStackView = build {
        $0.axis = .vertical
        $0.spacing = 5
        $0.backgroundColor = .clear
    }

    private lazy var countDownTimeLabel: UILabel = build {
        $0 <~ Style.Label.eventTimeLabel
    }

    private lazy var favouriteImageView: UIImageView = build {
        $0.contentMode = .scaleAspectFit
        $0.image = Style.Image.favouriteEmpty
        $0.tintColor = .gray
    }

    private lazy var firstEventParticipantLabel: UILabel = build {
        $0 <~ Style.Label.eventParticipantLabel
    }

    private lazy var secondEventParticipantLabel: UILabel = build {
        $0 <~ Style.Label.eventParticipantLabel
    }

    private var countDownTimer: CountDownable?
    private var item: SVSportEventModel?

    private var countDownTimerRepeatingTask: CompletionHandler? {
        let handler: CompletionHandler = { [weak self] in
            guard
                let strongSelf = self, let timer = strongSelf.countDownTimer
            else { return }

            var timeRemaining: TimeInterval = (timer.timeLimit - timer.timeElapsed)
            timeRemaining.round(.toNearestOrEven)

            strongSelf.countDownTimeLabel.text = timeRemaining.timeTillStart
        }
        return handler
    }

    private var didTapHandler: CompletionHandler?

    // MARK: - Lifecycle
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
        tapGestureSetup()
        backgroundColor = .clear
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        self.item = nil
        self.countDownTimer?.reset()
    }

    // MARK: - Public

    func configure(with item: SVSportEventModel?, didTapCompletion: @autoclosure @escaping CompletionHandler) {
        self.item = item
        self.didTapHandler = didTapCompletion
        timerConfiguration()
        firstEventParticipantLabel.text = item?.firstParticipant
        secondEventParticipantLabel.text = item?.secondParticipant
        countDownTimeLabel.text = item?.startTimeDescription
        favouriteImageView.image = (self.item?.isFavourite ?? false) ? Style.Image.favouriteFull : Style.Image.favouriteEmpty
    }

    // MARK: - Private

    private func setupUI() {
        addSubview(containerStackView)
        containerStackView.addArrangedSubview(countDownTimeLabel)
        containerStackView.addArrangedSubview(favouriteImageView)
        containerStackView.addArrangedSubview(UIView())
        containerStackView.addArrangedSubview(firstEventParticipantLabel)
        containerStackView.addArrangedSubview(secondEventParticipantLabel)

        containerStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        countDownTimeLabel.snp.makeConstraints { make in
            make.height.equalTo(10)
        }
        favouriteImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
        firstEventParticipantLabel.snp.makeConstraints { make in
            make.height.equalTo(10)
        }
    }

    func tapGestureSetup() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureAction))
        addGestureRecognizer(tapGesture)
    }

    @objc private func tapGestureAction() {
        self.item?.isFavourite = !(self.item?.isFavourite ?? false)
        didTapHandler?()
    }

    func timerConfiguration() {
        guard let eventDate = self.item?.startTime else { return }

        countDownTimer = SVCountdownTimer(endsOn: eventDate, repeatingTask: countDownTimerRepeatingTask)
        countDownTimer?.start()
    }
}
