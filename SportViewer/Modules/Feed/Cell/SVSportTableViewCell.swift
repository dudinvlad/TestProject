//
//  SVSportTableViewCell.swift
//  SportViewer
//
//  Created by Vladislav Dudin on 07.05.2022.
//

import UIKit
import SnapKit

class SVSportTableViewCell: UITableViewCell {

    // MARK: - Variables

    private lazy var containerStackView: UIStackView = build {
        $0.axis = .vertical
        $0.spacing = 15
        $0.backgroundColor = .clear
    }

    private lazy var headerContainerStackView: UIStackView = build {
        $0.axis = .horizontal
        $0.backgroundColor = Style.Color.darkGray
        $0.isLayoutMarginsRelativeArrangement = true
        $0.layoutMargins.left = 16
        $0.layoutMargins.right = 16
    }

    private lazy var sportNameLabel: UILabel = build {
        $0 <~ Style.Label.sportNameLabel
    }

    private lazy var chevronImageView: UIImageView = build {
        $0.image = Style.Image.chevronDown
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .white
    }

    private lazy var collectionLayout: UICollectionViewFlowLayout = build {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 5
        $0.minimumInteritemSpacing = 5
    }

    private lazy var collectionView: UICollectionView = build(.init(frame: .zero, collectionViewLayout: collectionLayout)) {
        $0.register(SVEventCollectionViewCell.self)
        $0.delegate = self
        $0.dataSource = self
        $0.backgroundColor = .clear
    }

    private var item: SVSportModel?

    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .clear
        selectionStyle = .none

        addSubViews()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        self.item = nil
    }

    // MARK: - Public

    func configurate(with item: SVSportModel, isExpanded: Bool) {
        self.item = item
        self.collectionView.reloadData()
        sportNameLabel.text = item.name
        chevronShoulAnimated(isExpanded: isExpanded)
    }

    // MARK: - Private
    private func addSubViews() {
        contentView.addSubview(containerStackView)
        containerStackView.addArrangedSubview(headerContainerStackView)
        headerContainerStackView.addArrangedSubview(sportNameLabel)
        headerContainerStackView.addArrangedSubview(UIView())
        headerContainerStackView.addArrangedSubview(chevronImageView)
        containerStackView.addArrangedSubview(collectionView)
    }

    private func setConstraints() {
        containerStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        headerContainerStackView.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        chevronImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width:20, height:15))
        }
    }

    private func chevronShoulAnimated(isExpanded: Bool) {
        if isExpanded {
            chevronImageView.transform = .init(rotationAngle: .pi)
        } else {
            chevronImageView.transform = .identity
        }
    }
}

extension SVSportTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return item?.event.count ?? .zero
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SVEventCollectionViewCell.reusebleId, for: indexPath) as? SVEventCollectionViewCell
        else {
            return .init()
        }

        var sortedEvents = item?.event.sorted(by: { $0.startTime.compare($1.startTime) == .orderedAscending })
        sortedEvents?.sort { ($0.isFavourite) && !($1.isFavourite) }
        let event = sortedEvents?[indexPath.row]

        cell.configure(with: event, didTapCompletion: collectionView.reloadData())
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalWidth = UIScreen.main.bounds.width
        let newWidth = (totalWidth - (self.collectionView(collectionView, layout: collectionViewLayout, minimumLineSpacingForSectionAt: indexPath.section))) / 3
        return CGSize(width: newWidth, height: 100)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
