//
//  MovieTableViewCell.swift
//  MovieSharing-iOS
//
//  Created by Muhammad Usman on 29/06/2021.
//

import UIKit
import Foundation

class MovieTableViewCell: UITableViewCell{
    
    // MARK: - IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    // MARK: - Properties
    
    private lazy var layout : UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 140, height: 180)
        return layout
    }()
    
    private var datasource : [MovieViewModel] = []{
        didSet{
            collectionView.reloadData()
        }
    }
    
    // MARK: - Configure Cell
    func configure(with viewModels: [MovieViewModel]) {
        collectionView.collectionViewLayout = layout
        datasource = viewModels
    }
    
}


// MARK: UICollectionViewDelegate

extension MovieTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasource.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(MovieCollectionViewCell.self, for: indexPath)
        cell.configure(with: datasource[indexPath.row])
        return cell
    }
}
