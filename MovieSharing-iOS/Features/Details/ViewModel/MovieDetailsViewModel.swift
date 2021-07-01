//
//  MovieDetailsViewModel.swift
//  MovieSharing-iOS
//
//  Created by Muhammad Usman on 30/06/2021.
//
//

import Combine
import Foundation

protocol MovieDetailsViewModelType {
    func request(_ request: Request)
    func makeRating()->(leftPart: Int, rightPart: Int, rating: Double)
}

/// define all states of view.
enum MovieDetailsViewModelState {
    case show(MovieDetailViewModel)
    case error(String)
    case noResults
}

class MovieDetailsViewModel {
    @Published var isLoading = false
    /// define immutable `stateDidUpdate` property so that subscriber can only read from it.
    private(set) lazy var stateDidUpdate = stateDidUpdateSubject.eraseToAnyPublisher()

    // MARK: - Private Properties

    private var cancellables: [AnyCancellable] = []
    private let useCase: MoviesUseCaseType
    private let stateDidUpdateSubject = PassthroughSubject<MovieDetailsViewModelState, Never>()

    // MARK: Initializer

    init(useCase: MoviesUseCaseType) {
        self.useCase = useCase
    }
}

extension MovieDetailsViewModel: MovieDetailsViewModelType {
    func request(_ request: Request) {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        isLoading = true
        useCase.movieDetails(request)
            .sink { [weak self] result in
                guard let `self` = self else { return }
                self.isLoading = false
                switch result {
                case .success(let value):
                    if let firstItem = value.items.first {
                        self.stateDidUpdateSubject.send(.show(self.prepareViewModel(movie: firstItem)))
                    } else {
                        self.stateDidUpdateSubject.send(.noResults)
                    }

                case .failure(let error):
                    self.stateDidUpdateSubject.send(.error(error.localizedDescription))
                }
            }.store(in: &cancellables)
    }

    func makeRating()->(leftPart: Int, rightPart: Int, rating: Double){
        let randomNumber = Double.random(in: 1.0...5.0)
        let randomNumbers = randomNumber.splitIntoParts(decimalPlaces: 2)
        return (leftPart: randomNumbers.leftPart, rightPart: randomNumbers.rightPart, rating: randomNumber)
    }
    
    private func prepareViewModel(movie: DetailItems) -> MovieDetailViewModel {
        return MovieDetailViewModelBuilder.prepareViewModel(movie: movie)
    }
}
