//
//  SettingsViewController.swift
//  MovieSharing-iOS
//
//  Created by Muhammad Usman on 29/06/2021.
//
//

import Combine
import UIKit

class SettingsViewController: UIViewController {
    // MARK: IBOutlet

    @IBOutlet var tableView: UITableView!

    // MARK: Properties

    private var datasource = ["EmptyCell",
                              "ProfileCell",
                              "AppleIdCell",
                              "EmptyCell",
                              "SwitchCell",
                              "ConnectedCell",
                              "OnCell",
                              "SimpleCell",
                              "OffCell"]
    private var cancellable: [AnyCancellable] = []

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    private func configureUI() {
        title = Constants.Settings.title
        tableView.tableFooterView = UIView()
        tableView.reloadData()
    }
}

// MARK:- Extension UITableViewDataSource

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: datasource[indexPath.row]) else { return UITableViewCell() }
        return cell
    }
}
