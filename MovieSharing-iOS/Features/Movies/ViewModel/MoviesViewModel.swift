//
//  MoviesViewModel.swift
//  MovieSharing-iOS
//
//  Created by Muhammad Usman on 29/06/2021.
//
//

import Combine
import Foundation

protocol MoviesViewModelType {
    func request(_ request: Request)
}

/// define all states of view.
enum MoviesViewModelState {
    case show([MovieSectionViewModel])
    case error(String)
    case noResults
}

class MoviesViewModel {
    @Published var isLoading = false
    /// define immutable `stateDidUpdate` property so that subscriber can only read from it.
    private(set) lazy var stateDidUpdate = stateDidUpdateSubject.eraseToAnyPublisher()

    // MARK: - Private Properties

    private var cancellables: [AnyCancellable] = []
    private let useCase: MoviesUseCaseType
    private let stateDidUpdateSubject = PassthroughSubject<MoviesViewModelState, Never>()
    private var movieItems = [MovieItems]()

    // MARK: Initializer

    init(useCase: MoviesUseCaseType) {
        self.useCase = useCase
    }
}

extension MoviesViewModel: MoviesViewModelType {
    func request(_ request: Request) {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        isLoading = true
        useCase.request(request)
            .sink { [weak self] result in
                guard let `self` = self else { return }
                self.isLoading = false
                switch result {
                case .success(let value):
                    self.movieItems = value.items
                    self.stateDidUpdateSubject.send(.show(self.prepareGridDatasource()))
                case .failure(let error):
                    self.stateDidUpdateSubject.send(.error(error.localizedDescription))
                }
            }.store(in: &cancellables)
    }

    func prepareGridDatasource() -> [MovieSectionViewModel] {
        var gridDatasource = [MovieSectionViewModel]()
        let datasource = makeDatasource(movies: movieItems)
        let chunkedArrays = datasource.chunked(into: 10)
        chunkedArrays.forEach { array in
            gridDatasource.append(MovieSectionViewModel(viewModels: array))
        }
        return gridDatasource
    }

    func prepareListDatasource() -> [MovieViewModel] {
        return makeDatasource(movies: movieItems)
    }

    private func makeDatasource(movies: [MovieItems]) -> [MovieViewModel] {
        return movies.map { movie in
            MovieViewModelBuilder.prepareViewModel(movie: movie)
        }
    }
}
