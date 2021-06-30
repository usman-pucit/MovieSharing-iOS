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
    
    // MARK: Properties

    var videoId: String?
    var playlistId: String?
    private var viewModel: MovieDetailsViewModel!
    private var cancellable: [AnyCancellable] = []
    
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MovieDetailsViewModel(useCase: MoviesUseCase())
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.stateDidUpdate.sink(receiveValue: { [weak self] state in
            guard let `self` = self else{return}
            self.handleResponse(state)
        }).store(in: &cancellable)
        
        if let request = Request.movieDetails(videoId, playlistId: playlistId) {
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
    
    
}
