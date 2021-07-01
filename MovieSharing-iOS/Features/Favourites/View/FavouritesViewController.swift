//
//  FavouritesViewController.swift
//  MovieSharing-iOS
//
//  Created by Muhammad Usman on 29/06/2021.
//
//

import Combine
import UIKit

class FavouritesViewController: UIViewController {
    @IBOutlet var tableView: UITableView!

    // MARK: Properties

    private var viewModel: FavouritesViewModel!
    private var cancellable: [AnyCancellable] = []
    private lazy var datasource = [MovieViewModel]()
    private lazy var filteredDatasource = [MovieViewModel]()
    private lazy var searchBar = UISearchBar(frame: .zero)
    private var isSearchBarActive = false

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = FavouritesViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI()
    }

    private func configureUI() {
        title = "Favourites"
        isSearchBarActive = false
        datasource = SharedDataManager.shared
        filteredDatasource = datasource
        searchBar.placeholder = "Search"
        searchBar.delegate = self
        let micImage = UIImage(systemName: "mic.fill")
        searchBar.setImage(micImage, for: .bookmark, state: .normal)
        searchBar.showsBookmarkButton = true
        navigationItem.titleView = searchBar

        tableView.tableFooterView = UIView()
        tableView.registerNib(cellClass: MovieListViewCell.self)
        tableView.registerNib(cellClass: MovieHeaderViewCell.self)
        tableView.reloadData()
    }

    @objc func cancelButtonTapped() {
        searchBar.text = ""
        searchBar.endEditing(true)
        isSearchBarActive = false
        filteredDatasource.removeAll()
        navigationItem.rightBarButtonItem = nil
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        cancelButtonTapped()
    }
}

extension FavouritesViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if let isEmpty = searchBar.text?.isEmpty, isEmpty{
            isSearchBarActive = false
        }else{
            isSearchBarActive = true
        }
        
        let cancelSearchBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonTapped))
        navigationItem.setRightBarButton(cancelSearchBarButtonItem, animated: true)
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        isSearchBarActive = true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearchBarActive = false
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isSearchBarActive = false
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearchBarActive = false
        } else {
            filteredDatasource = datasource.filter { $0.title.contains(searchText) }
            isSearchBarActive = true
        }
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate

extension FavouritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let coordinator = MoviesCoordinator(navigationController: navigationController)
        if isSearchBarActive {
            coordinator.start(filteredDatasource[indexPath.row])
        } else {
            coordinator.start(datasource[indexPath.row])
        }
        
    }
}

// MARK: - UITableViewDatasource

extension FavouritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearchBarActive {
            return filteredDatasource.count
        } else {
            return datasource.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: MovieListViewCell.self)
        if isSearchBarActive {
            cell.configure(with: filteredDatasource[indexPath.row])
        } else {
            cell.configure(with: datasource[indexPath.row])
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let stringHeight = datasource[indexPath.row].title.height(constraintedWidth: tableView.frame.size.width - 50, font: UIFont.systemFont(ofSize: 17))
        return 260 + stringHeight
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if datasource.count == 0 {
            return UIView()
        }
        if isSearchBarActive, filteredDatasource.count == 0 {
            return UIView()
        }
        let headerView = tableView.dequeueReusableCell(withClass: MovieHeaderViewCell.self)
        headerView.configure("Category")
        return headerView
    }
}
