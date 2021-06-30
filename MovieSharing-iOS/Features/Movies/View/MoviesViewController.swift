//
//  MoviesViewController.swift
//  MovieSharing-iOS
//
//  Created by Muhammad Usman on 29/06/2021.
//  
//

import UIKit
import Combine

enum TableViewState{
    case grid
    case list
    
    var headerTitle: String?{
        switch self {
        case .grid:
            return nil
        case .list:
            return "Category"
        }
    }
    
    var headerHeight: CGFloat{
        switch self {
        case .grid:
            return 0.0
        case .list:
            return 50.0
        }
    }
    
    var cellHeight: CGFloat{
        switch self {
        case .grid:
            return 330
        case .list:
            return 270
        }
    }
}

class MoviesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties

    private var viewModel: MoviesViewModel!
    private var cancellable: [AnyCancellable] = []
    private lazy var activityViewController: ActivityViewController = ActivityViewController.loadFromNib()
    private var listState: TableViewState = .grid
    private lazy var gridDataSource: [MovieSectionViewModel] = []{
        didSet{
            tableView.reloadData()
        }
    }
    
    private lazy var listDataSource: [MovieViewModel] = []{
        didSet{
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
    
    private func configureUI(){
        title = "Movies"
        tableView.tableFooterView = UIView()
        tableView.registerNib(cellClass: MovieHeaderViewCell.self)
        
        // adding acvtivity loader screen
        add(activityViewController)
    }
    
    private func bindViewModel() {
        viewModel.stateDidUpdate.sink(receiveValue: { [weak self] state in
            guard let `self` = self else {return}
            self.handleResponse(state)
        }).store(in: &cancellable)
        
        viewModel.$isLoading.sink(receiveValue: { [weak self] isLoading in
            guard let `self` = self else {return}
            self.activityViewController.view.isHidden = !isLoading
        }).store(in: &cancellable)
        
        viewModel.request(Request.movies())
    }
    
    private func handleResponse(_ result: MoviesViewModelState) {
        switch result {
        case .show(let movies):
            gridDataSource = movies
        case .noResults:
            handleError("No results")
        case .error(let message):
            handleError(message)
        }
    }
    
//    private func renderListView(){
//        if listState == .list {
//            var rows = [MovieViewModel]()
//            rows.append(MovieViewModel(title: "A", image: nil))
//            rows.append(MovieViewModel(title: "B", image: nil))
//            rows.append(MovieViewModel(title: "C", image: nil))
//            rows.append(MovieViewModel(title: "A", image: nil))
//            rows.append(MovieViewModel(title: "B", image: nil))
//            rows.append(MovieViewModel(title: "C", image: nil))
//            rows.append(MovieViewModel(title: "A", image: nil))
//            rows.append(MovieViewModel(title: "B", image: nil))
//            rows.append(MovieViewModel(title: "C", image: nil))
//            rows.append(MovieViewModel(title: "D", image: nil))
//            rows.append(MovieViewModel(title: "E", image: nil))
//            rows.append(MovieViewModel(title: "F", image: nil))
//            rows.append(MovieViewModel(title: "D", image: nil))
//            rows.append(MovieViewModel(title: "E", image: nil))
//            rows.append(MovieViewModel(title: "F", image: nil))
//            rows.append(MovieViewModel(title: "D", image: nil))
//            rows.append(MovieViewModel(title: "E", image: nil))
//            rows.append(MovieViewModel(title: "F", image: nil))
//            listDataSource = rows
//        }else{
//        var sections = [MovieSectionViewModel]()
//        var rows = [MovieViewModel]()
//        rows.append(MovieViewModel(title: "A", image: nil))
//        rows.append(MovieViewModel(title: "B", image: nil))
//        rows.append(MovieViewModel(title: "C", image: nil))
//        rows.append(MovieViewModel(title: "A", image: nil))
//        rows.append(MovieViewModel(title: "B", image: nil))
//        rows.append(MovieViewModel(title: "C", image: nil))
//        rows.append(MovieViewModel(title: "A", image: nil))
//        rows.append(MovieViewModel(title: "B", image: nil))
//        rows.append(MovieViewModel(title: "C", image: nil))
//        sections.append(MovieSectionViewModel(viewModels: rows))
//
//        rows.removeAll()
//        rows.append(MovieViewModel(title: "D", image: nil))
//        rows.append(MovieViewModel(title: "E", image: nil))
//        rows.append(MovieViewModel(title: "F", image: nil))
//        rows.append(MovieViewModel(title: "D", image: nil))
//        rows.append(MovieViewModel(title: "E", image: nil))
//        rows.append(MovieViewModel(title: "F", image: nil))
//        rows.append(MovieViewModel(title: "D", image: nil))
//        rows.append(MovieViewModel(title: "E", image: nil))
//        rows.append(MovieViewModel(title: "F", image: nil))
//        sections.append(MovieSectionViewModel(viewModels: rows))
//        dataSource = sections
//        }
//    }
    
    private func handleError(_ message: String) {
        showAlert(with: "Error", message: message)
    }
    
    @IBAction func didChangeSegmentControl(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            listState = .grid
            gridDataSource = viewModel.prepareGridDatasource()
        }else{
            listState = .list
            listDataSource = viewModel.prepareListDatasource()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        remove(activityViewController)
    }
}

// MARK: - UITableViewDelegate

extension MoviesViewController: UITableViewDelegate{}

// MARK: - UITableViewDatasource

extension MoviesViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if listState == .grid {
            return gridDataSource.count
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if listState == .grid {
            return 1
        }else{
            return listDataSource.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if listState == .grid {
            let cell = tableView.dequeueReusableCell(withClass: MovieTableViewCell.self)
            cell.configure(with: gridDataSource[indexPath.section].viewModels)
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withClass: MovieListViewCell.self)
            cell.configure(with: listDataSource[indexPath.row])
            return cell
        }
        
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return listState.cellHeight
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableCell(withClass: MovieHeaderViewCell.self)
        headerView.configure("Category")
        return headerView
    }
}
