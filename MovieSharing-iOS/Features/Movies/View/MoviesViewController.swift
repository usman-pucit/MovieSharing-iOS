//
//  MoviesViewController.swift
//  MovieSharing-iOS
//
//  Created by Muhammad Usman on 29/06/2021.
//
//

import Combine
import UIKit

enum TableViewState {
    case grid
    case list

    var cellHeight: CGFloat {
        switch self {
        case .grid:
            return 350
        case .list:
            return 260
        }
    }
}

class MoviesViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    // MARK: Properties

    private var viewModel: MoviesViewModel!
    private var cancellable: [AnyCancellable] = []
    private lazy var activityViewController = ActivityViewController.loadFromNib()
    private var listState: TableViewState = .grid
    private lazy var gridDataSource: [MovieSectionViewModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private lazy var listDataSource: [MovieViewModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        viewModel = MoviesViewModel(useCase: MoviesUseCase())
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func configureUI() {
        title = Constants.Movies.title
        tableView.tableFooterView = UIView()
        tableView.registerNib(cellClass: MovieHeaderViewCell.self)
        tableView.registerNib(cellClass: MovieListViewCell.self)
        // adding acvtivity loader screen
        add(activityViewController)
    }
    
    private func bindViewModel() {
        viewModel.stateDidUpdate.sink(receiveValue: { [weak self] state in
            guard let `self` = self else { return }
            self.handleResponse(state)
        }).store(in: &cancellable)
        
        viewModel.$isLoading.sink(receiveValue: { [weak self] isLoading in
            guard let `self` = self else { return }
            self.activityViewController.view.isHidden = !isLoading
            self.tabBarController?.tabBar.isHidden = isLoading
            self.navigationController?.navigationBar.isHidden = isLoading
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
            self.view.setNeedsDisplay()
        }).store(in: &cancellable)
        
        viewModel.request(Request.movies())
    }
    
    private func handleResponse(_ result: MoviesViewModelState) {
        switch result {
        case .show(let movies):
            gridDataSource = movies
        case .noResults:
            handleError(Constants.Error.noResults)
        case .error(let message):
            handleError(message)
        }
    }
    
    private func handleError(_ message: String) {
        showAlert(with: Constants.Error.errorTitle, message: message)
    }
    
    @IBAction func didChangeSegmentControl(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            tableView.allowsSelection = false
            listState = .grid
            gridDataSource = viewModel.prepareGridDatasource()
        } else {
            tableView.allowsSelection = true
            listState = .list
            listDataSource = viewModel.prepareListDatasource()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        remove(activityViewController)
    }
}

extension MoviesViewController: ItemSelected {
    func didItemGetSelected(movie: MovieViewModel) {
        let coordinator = MoviesCoordinator(navigationController: navigationController)
        coordinator.start(movie)
    }
}

// MARK: - UITableViewDelegate

extension MoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if listState == .list {
            didItemGetSelected(movie: listDataSource[indexPath.row])
        }
    }
}

// MARK: - UITableViewDatasource

extension MoviesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if listState == .grid {
            return gridDataSource.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if listState == .grid {
            return 1
        } else {
            return listDataSource.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if listState == .grid {
            let cell = tableView.dequeueReusableCell(withClass: MovieTableViewCell.self)
            cell.delegate = self
            cell.configure(with: gridDataSource[indexPath.section].viewModels)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withClass: MovieListViewCell.self)
            cell.configure(with: listDataSource[indexPath.row])
            return cell
        }
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if listState == .grid {
            return listState.cellHeight
        } else {
            let stringHeight = listDataSource[indexPath.row].title.height(constraintedWidth: tableView.frame.size.width - 50, font: UIFont.systemFont(ofSize: 17))
            return listState.cellHeight + stringHeight
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if listDataSource.count == 0, gridDataSource.count == 0 {
            return UIView()
        }
        let headerView = tableView.dequeueReusableCell(withClass: MovieHeaderViewCell.self)
        headerView.configure(Constants.Movies.headerTitle)
        return headerView
    }
}
