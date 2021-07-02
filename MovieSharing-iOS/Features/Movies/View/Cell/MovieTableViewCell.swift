//
//  MovieTableViewCell.swift
//  MovieSharing-iOS
//
//  Created by Muhammad Usman on 29/06/2021.
//

import Combine
import Foundation
import UIKit

class MovieTableViewCell: UITableViewCell {
    // MARK: - IBOutlet

    @IBOutlet var collectionView: UICollectionView!
    var delegate: ItemSelected?
    
//    private(set) lazy var didSelectItem = selectedItemSubject.eraseToAnyPublisher()
//    private let selectedItemSubject = PassthroughSubject<MovieViewModel, Never>()
//
    
    // MARK: - Properties

    private var cancellable: [AnyCancellable] = []
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        layout.minimumLineSpacing = 20
        layout.itemSize = CGSize(width: 175, height: 310)
        return layout
    }()
    
    private var datasource: [MovieViewModel] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private var isGridView: Bool = true
    
    // MARK: - Configure Cell

    func configure(with viewModels: [MovieViewModel]) {
        collectionView.collectionViewLayout = layout
        datasource = viewModels
    }
}

extension MovieTableViewCell: ItemSelected {
    func didItemGetSelected(movie: MovieViewModel) {
        delegate?.didItemGetSelected(movie: movie)
    }
}

// MARK: UICollectionViewDelegate

extension MovieTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {}
}

// MARK: UICollectionViewDataSource

extension MovieTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasource.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(MovieCollectionViewCell.self, for: indexPath)
        cell.delegate = self
        cell.configure(with: datasource[indexPath.row])
        return cell
    }
}
