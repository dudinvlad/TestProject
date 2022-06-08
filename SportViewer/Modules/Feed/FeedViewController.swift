//
//  FeedViewController.swift
//  SportViewer
//
//  Created Vladislav Dudin on 06.05.2022.
//

import UIKit

private typealias Module = FeedModule
private typealias View = Module.ViewController

extension Module {
    final class ViewController: BaseViewController {
        // MARK: - Dependencies

        var output: ViewOutput!
        var expandedIndexSet: IndexSet = .init()

        // MARK: - Variables

        private lazy var tableView: UITableView = build(.init()) {
            $0.separatorStyle = .none
            $0.backgroundColor = .clear
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.delegate = self
            $0.dataSource = self
            $0.register(SVSportTableViewCell.self)
        }

        // MARK: - Lifecycle

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        init() {
            super.init(nibName: nil, bundle: nil)

        }

        override func viewDidLoad() {
            super.viewDidLoad()

            output?.didLoad()
            initialSetup()
        }

        // MARK: - Private

        private func initialSetup() {
            view.addSubview(tableView)
            setConstraints()
        }

        private func setConstraints() {
            tableView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
    }
}

private extension View { }

extension View: Module.ViewInput {
    func eventsDidLoad() {
        tableView.reloadData()
    }
}

extension View: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.output.getSportEvents().count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: SVSportTableViewCell.reusebleId, for: indexPath) as? SVSportTableViewCell
        else {
            return .init()
        }

        cell.configurate(with: self.output.getSportEvents()[indexPath.row], isExpanded: expandedIndexSet.contains(indexPath.row))

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if expandedIndexSet.contains(indexPath.row) {
            expandedIndexSet.remove(indexPath.row)
        } else {
            expandedIndexSet.insert(indexPath.row)
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
