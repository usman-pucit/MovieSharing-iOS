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
    @IBOutlet var labeDecimalRating: UILabel!
    @IBOutlet var thumbnailShadowView: UIView!
    @IBOutlet var posterView: UIView!
    
    // MARK: Properties

    var movie: MovieViewModel!
    private var activityIndicator = ActivityViewController.loadFromNib()
    private var viewModel: MovieDetailsViewModel!
    private var cancellable: [AnyCancellable] = []
    private var isViewAppeared = false{
        didSet{
            if isViewAppeared && isLoading {
                setupViewVisibility()
            }
        }
    }
    private var isLoading = true{
        didSet{
            if isViewAppeared && isLoading {
                setupViewVisibility()
            }
        }
    }
    private var isFirstTimeLoaded = true
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MovieDetailsViewModel(useCase: MoviesUseCase())
        configureUI()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBarButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        isViewAppeared = true
        if isFirstTimeLoaded {
            isFirstTimeLoaded = false
            setViewsOnDidAppear()
        }
    }
    
    private func setViewsOnDidAppear(){
        posterView.addGradientBackground()
    }
    
    // MARK: Fuction
    private func configureUI() {
        title = movie.channelTitle
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.isHidden = true
        let rating = viewModel.makeRating()
        labelRating.text = "\(rating.leftPart)"
        labeDecimalRating.text = ".\(rating.rightPart)"
        cosmosView.rating = rating.rating
        cosmosView.settings.starMargin = 10
        cosmosView.settings.starSize = 16
        cosmosView.settings.fillMode = .full
        imageThumbnail.addGradientBackground([UIColor.black.withAlphaComponent(0.3).cgColor, UIColor.black.withAlphaComponent(0.0).cgColor,
                                              UIColor.black.withAlphaComponent(0.3).cgColor], locations: [0, 0.5, 1])
        thumbnailShadowView.addShadow(offset: CGSize(width: 0, height: 3), color: UIColor.black, radius: 2.0, opacity: 0.35)
        add(activityIndicator)
        activityIndicator.setTitle(title: Constants.Details.loadingMessage)
    }
    
    //Function setup navigation bar
    private func setupNavigationBarButton() {
        var image: UIImage?
        let id = movie.videoId
        
        if SharedDataManager.shared.contains(where: { movie in movie.videoId == id }) {
            image = UIImage(named: Constants.Icons.favoritesLight)
        } else {
            image = UIImage(named: Constants.Icons.favoriteDisabled)
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
        
        viewModel.$isLoading.sink(receiveValue: { isLoading in
            self.isLoading = !isLoading
        }).store(in: &cancellable)
        
        viewModel.request(Request.movieDetails(movie.videoId))
    }
    
    private func setupViewVisibility(){
        self.activityIndicator.view.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = false
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
        self.view.setNeedsDisplay()
    }
    
    private func handleResponse(_ result: MovieDetailsViewModelState) {
        switch result {
        case .show(let details):
            render(details: details)
        case .noResults:
            handleError(Constants.Error.noResults)
        case .error(let message):
            handleError(message)
        }
    }
    
    private func render(details: MovieDetailViewModel) {
        labelTitle.text = details.title
        labelGenres.text = details.genre
        labelDescription.text = movie.description
        imagePoster.kf.setImage(with: details.posterImage)
        imageThumbnail.kf.setImage(with: details.thumnailImage)
    }
    
    private func handleError(_ message: String) {
        showAlert(with: Constants.Error.errorTitle, message: message)
    }
    
    @objc func favouriteButtonTapped(_ sender: Any) {
        let id = movie.videoId
        
        if SharedDataManager.shared.contains(where: { movie in movie.videoId == id }) {
            if let index = SharedDataManager.shared.firstIndex(where: { $0.videoId == id }) {
                SharedDataManager.shared.remove(at: index)
            }
        } else {
            SharedDataManager.shared.append(movie)
        }
        setupNavigationBarButton()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        remove(activityIndicator)
    }
}
