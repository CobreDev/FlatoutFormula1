//
//  UICollectionViewCell.swift
//  Formula 1
//
//  Created by Gio on 11/16/19.
//  Copyright © 2022 Gio. All rights reserved.
//

import UIKit

// MARK: - Collection View extension
extension UICollectionView {
    func registerCell(_ cellClass: UICollectionViewCell.Type) {
        let reuseIdentifier = cellClass.reuseIdentifier
        register(cellClass, forCellWithReuseIdentifier: reuseIdentifier)
    }
}
