//
//  MovieDetailsViewController.swift
//  MovieSharing-iOS
//
//  Created by Muhammad Usman on 30/06/2021.
//  
//

import UIKit
import Combine
import Kingfisher

class MovieDetailsViewController: UIViewController {

    // MARK: IBOutlets
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelGenres: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var imagePoster: UIImageView!
    @IBOutlet weak var imageThumbnail: UIImageView!
    @IBOutlet weak var rightBarButtonItem: UIBarButtonItem!
    
    // MARK: Properties

    var movie: MovieViewModel!
    private var viewModel: MovieDetailsViewModel!
    private var cancellable: [AnyCancellable] = []
    
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MovieDetailsViewModel(useCase: MoviesUseCase())
        bindViewModel()
        configureUI()
        setupNavigationBarButton()
    }
    
    private func configureUI(){
        title = "Movie title"
    }
    
    private func setupNavigationBarButton(){
        var image: UIImage?
        var id = UUID().uuidString
        if let videoId = movie.videoId {
            id = videoId
        }else if let playlistId = movie.playlistId{
            id = playlistId
        }
        
        if DataManager.shared.contains(where: { movie in movie.videoId == id || movie.playlistId == id}) {
            image = UIImage(systemName: "heart.fill")
        }else{
            image = UIImage(systemName: "heart")
        }
        
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(favouriteButtonTapped), for: .touchUpInside)
//        button.frame=CGRect(x: 10, y: 0, width: 50, height: 50)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    private func bindViewModel() {
        viewModel.stateDidUpdate.sink(receiveValue: { [weak self] state in
            guard let `self` = self else{return}
            self.handleResponse(state)
        }).store(in: &cancellable)
        
        if let request = Request.movieDetails(movie.videoId, playlistId: movie.playlistId) {
            viewModel.request(request)
        }else{
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
    
    private func render(details: MovieDetailViewModel){
        labelTitle.text = details.title
        labelGenres.text = details.genre
        labelDescription.text = details.description
        imagePoster.kf.setImage(with: details.posterImage)
        imageThumbnail.kf.setImage(with: details.thumnailImage)
    }
    
    private func handleError(_ message: String) {
        showAlert(with: "Error", message: message)
    }
    
    
    @objc func favouriteButtonTapped(_ sender: Any){
        var id = UUID().uuidString
        if let videoId = movie.videoId {
            id = videoId
        }else if let playlistId = movie.playlistId{
            id = playlistId
        }
        
        if DataManager.shared.contains(where: { movie in movie.videoId == id || movie.playlistId == id}) {
            print("\n ## Object already there ..... ## \n")
        }else{
            DataManager.shared.append(self.movie)
            setupNavigationBarButton()
            print("\n ## Object already added ## \n")
        }
    }
    
}
