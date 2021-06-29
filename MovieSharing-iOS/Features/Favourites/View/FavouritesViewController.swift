//
//  FavouritesViewController.swift
//  MovieSharing-iOS
//
//  Created by Muhammad Usman on 29/06/2021.
//  
//

import UIKit
import Combine

class FavouritesViewController: UIViewController {

    // MARK: Properties

    private var viewModel: FavouritesViewModel!
    private var cancellable: [AnyCancellable] = []
    
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = FavouritesViewModel()
        configureUI()
        bindViewModel()
    }
    
    private func configureUI(){
        title = "Favourites"
    }
    
    private func bindViewModel() {
        viewModel.stateDidUpdate.sink(receiveValue: { [unowned self] state in
            // Todo ...
        }).store(in: &cancellable)
    }
}
