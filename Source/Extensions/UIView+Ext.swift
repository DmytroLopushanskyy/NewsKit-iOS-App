//
//  UIView+Ext.swift
//  NewsKit4
//
//  Created by Дмитро Лопушанський on 10/1/19.
//  Copyright © 2019 DmytroLopushanskyy. All rights reserved.
//

import UIKit

extension UIView {
    func stretchToSuperview(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        self.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
