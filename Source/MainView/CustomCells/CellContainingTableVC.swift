//
//  CustomCell.swift
//  NewsKit3
//
//  Created by Дмитро Лопушанський on 9/30/19.
//  Copyright © 2019 DmytroLopushanskyy. All rights reserved.
//

import UIKit

class CellContainingTableVC: UICollectionViewCell {

    var viewC: UIViewController?

    override func prepareForReuse() {
        viewC?.view.removeFromSuperview()
        viewC = nil
    }

    func configureCell() {
        let screenwidth = UIScreen.main.bounds.width

        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 150).isActive = true
        self.widthAnchor.constraint(equalToConstant: screenwidth).isActive = true
        self.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        self.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        self.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
    }

    func addViewController(collectionView: CollectionViewController) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewC = storyboard.instantiateViewController(withIdentifier: "TableViewController")
        collectionView.addChild(viewC)
        self.contentView.addSubview(viewC.view)
        self.contentView.stretchToSuperview(viewC.view)

        self.viewC = viewC

        viewC.didMove(toParent: collectionView)
        viewC.view.layoutIfNeeded()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
