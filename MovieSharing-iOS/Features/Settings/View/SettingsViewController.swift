//
//  SettingsViewController.swift
//  MovieSharing-iOS
//
//  Created by Muhammad Usman on 29/06/2021.
//  
//

import UIKit
import Combine

class SettingsViewController: UIViewController {

    // MARK: Properties

    private var viewModel: SettingsViewModel!
    private var cancellable: [AnyCancellable] = []
    
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SettingsViewModel()
        configureUI()
        bindViewModel()
    }
    
    private func configureUI(){
        title = "Settings"
    }
    
    private func bindViewModel() {
        viewModel.stateDidUpdate.sink(receiveValue: { [unowned self] state in
            // Todo ...
        }).store(in: &cancellable)
    }
}
