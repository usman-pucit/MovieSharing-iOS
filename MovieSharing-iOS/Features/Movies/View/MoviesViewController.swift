//
//  MoviesViewController.swift
//  MovieSharing-iOS
//
//  Created by Muhammad Usman on 29/06/2021.
//  
//

import UIKit
import Combine

class MoviesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties

    private var viewModel: MoviesViewModel!
    private var cancellable: [AnyCancellable] = []
    private lazy var dataSource: [MovieSectionViewModel] = []{
        didSet{
            tableView.reloadData()
        }
    }
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MoviesViewModel(useCase: MoviesUseCase())
        bindViewModel()
        configureUI()
    }
    
    private func configureUI(){
        var sections = [MovieSectionViewModel]()
        var rows = [MovieViewModel]()
        rows.append(MovieViewModel(title: "A", image: nil))
        rows.append(MovieViewModel(title: "B", image: nil))
        rows.append(MovieViewModel(title: "C", image: nil))
        rows.append(MovieViewModel(title: "A", image: nil))
        rows.append(MovieViewModel(title: "B", image: nil))
        rows.append(MovieViewModel(title: "C", image: nil))
        rows.append(MovieViewModel(title: "A", image: nil))
        rows.append(MovieViewModel(title: "B", image: nil))
        rows.append(MovieViewModel(title: "C", image: nil))
        sections.append(MovieSectionViewModel(viewModels: rows))
        
        rows.removeAll()
        rows.append(MovieViewModel(title: "D", image: nil))
        rows.append(MovieViewModel(title: "E", image: nil))
        rows.append(MovieViewModel(title: "F", image: nil))
        rows.append(MovieViewModel(title: "D", image: nil))
        rows.append(MovieViewModel(title: "E", image: nil))
        rows.append(MovieViewModel(title: "F", image: nil))
        rows.append(MovieViewModel(title: "D", image: nil))
        rows.append(MovieViewModel(title: "E", image: nil))
        rows.append(MovieViewModel(title: "F", image: nil))
        sections.append(MovieSectionViewModel(viewModels: rows))
        dataSource = sections
    }
    
    private func bindViewModel() {
        viewModel.stateDidUpdate.sink(receiveValue: { [weak self] state in
            guard let `self` = self else {return}
            self.handleResponse(state)
        }).store(in: &cancellable)
    }
    
    private func handleResponse(_ result: MoviesViewModelState) {
        switch result {
        case .show(let movies):
            break
//            configure(with: movies)
        case .noResults:
            handleError("No results")
        case .error(let message):
            handleError(message)
        }
    }
    
    private func handleError(_ message: String) {}
}

// MARK: - UITableViewDelegate

extension MoviesViewController: UITableViewDelegate{
    
}

// MARK: - UITableViewDatasource

extension MoviesViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: MovieTableViewCell.self)
        cell.configure(with: dataSource[indexPath.row].viewModels)
        return cell
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
