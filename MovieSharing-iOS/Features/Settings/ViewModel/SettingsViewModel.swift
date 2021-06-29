//
//  SettingsViewModel.swift
//  MovieSharing-iOS
//
//  Created by Muhammad Usman on 29/06/2021.
//  
//

import Combine
import Foundation

protocol SettingsViewModelType {}

/// define all states of view.
enum SettingsViewModelState {
    case show(Any)
    case error(String)
}

class SettingsViewModel {
    
    @Published var isLoading = false
    /// define immutable `stateDidUpdate` property so that subscriber can only read from it.
    private(set) lazy var stateDidUpdate = stateDidUpdateSubject.eraseToAnyPublisher()
    
    // MARK: - Private Properties
    
    private var cancellables: [AnyCancellable] = []
    private let stateDidUpdateSubject = PassthroughSubject<SettingsViewModelState, Never>()
}

extension SettingsViewModel: SettingsViewModelType {}
