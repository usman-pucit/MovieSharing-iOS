//
//  MovieDetailsViewController.swift
//  MovieSharing-iOS
//
//  Created by Muhammad Usman on 30/06/2021.
//
//

import Combine
import Cosmos
import Kingfisher
import UIKit

class MovieDetailsViewController: UIViewController {
    // MARK: IBOutlets
    
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var labelGenres: UILabel!
    @IBOutlet var labelDescription: UILabel!
    @IBOutlet var imagePoster: UIImageView!
    @IBOutlet var imageThumbnail: UIImageView!
    @IBOutlet var cosmosView: CosmosView!
    @IBOutlet var labelRating: UILabel!
    @IBOutlet var mainView: UIView!
    
    // MARK: Properties

    var movie: MovieViewModel!
    private var activityIndicator : ActivityViewController = ActivityViewController.loadFromNib()
    private var viewModel: MovieDetailsViewModel!
    private var cancellable: [AnyCancellable] = []
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MovieDetailsViewModel(useCase: MoviesUseCase())
        configureUI()
        bindViewModel()
        setupNavigationBarButton()
    }
    
    private func configureUI() {
        title = "Movie title"
        let randomInt = Int.random(in: 1 ... 5)
        cosmosView.rating = Double(randomInt)
        cosmosView.settings.starMargin = 10
        labelRating.text = "\(randomInt)"
        mainView.addShadow(offset: CGSize(width: 0, height: 3), color: UIColor.black, radius: 2.0, opacity: 0.35)
        add(activityIndicator)
    }
    
    private func setupNavigationBarButton() {
        var image: UIImage?
        var id = UUID().uuidString
        if let videoId = movie.videoId {
            id = videoId
        } else if let playlistId = movie.playlistId {
            id = playlistId
        }
        
        if SharedDataManager.shared.contains(where: { movie in movie.videoId == id || movie.playlistId == id }) {
            image = UIImage(systemName: "heart.fill")
        } else {
            image = UIImage(systemName: "heart")
        }
        
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(favouriteButtonTapped), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: button)
        navigationItem.rightBarButtonItem = barButton
    }
    
    private func bindViewModel() {
        viewModel.stateDidUpdate.sink(receiveValue: { [weak self] state in
            guard let `self` = self else { return }
            self.handleResponse(state)
        }).store(in: &cancellable)
        
        activityIndicator.setTitle(title: "Loading details")
        viewModel.$isLoading.sink(receiveValue: { isLoading in
            self.activityIndicator.view.isHidden = !isLoading
        }).store(in: &cancellable)
        
        if let request = Request.movieDetails(movie.videoId, playlistId: movie.playlistId, channelId: movie.channelId) {
            viewModel.request(request)
        } else {
            handleError("Inavlid request")
        }
    }
    
    private func handleResponse(_ result: MovieDetailsViewModelState) {
        switch result {
        case .show(let details):
            render(details: details)
        case .noResults:
            handleError("No results")
        case .error(let message):
            handleError(message)
        }
    }
    
    private func render(details: MovieDetailViewModel) {
        labelTitle.text = details.title
        labelGenres.text = details.genre
        labelDescription.text = details.description
        imagePoster.kf.setImage(with: details.posterImage)
        imageThumbnail.kf.setImage(with: details.thumnailImage)
    }
    
    private func handleError(_ message: String) {
        showAlert(with: "Error", message: message)
    }
    
    @objc func favouriteButtonTapped(_ sender: Any) {
        var id = UUID().uuidString
        if let videoId = movie.videoId {
            id = videoId
        } else if let playlistId = movie.playlistId {
            id = playlistId
        }
        
        if !SharedDataManager.shared.contains(where: { movie in movie.videoId == id || movie.playlistId == id }) {
            SharedDataManager.shared.append(movie)
            setupNavigationBarButton()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        remove(activityIndicator)
    }
}
