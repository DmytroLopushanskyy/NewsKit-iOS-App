//
//  CustomCellWithLabel.swift
//  NewsKit4
//
//  Created by Дмитро Лопушанський on 10/1/19.
//  Copyright © 2019 DmytroLopushanskyy. All rights reserved.
//

import UIKit

class NewsCell: UICollectionViewCell {

    func configureCell(collectionView: CollectionViewController) {
        self.backgroundColor = .blue
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
