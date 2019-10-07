//
//  CustomCellWithLabel.swift
//  NewsKit4
//
//  Created by Дмитро Лопушанський on 10/1/19.
//  Copyright © 2019 DmytroLopushanskyy. All rights reserved.
//

import UIKit

class NewsCell: UICollectionViewCell {
    let screenwidth = UIScreen.main.bounds.width

    func configureCell(collectionView: MainScreenCollectionVC, article: ArticleData) {
        let color: UIColor
        let reversedColor: UIColor
        if #available(iOS 13.0, *) {
            color = dynamicColor
            reversedColor = dynamicColorReversed
        } else {
            color = .white
            reversedColor = .black
        }
        self.backgroundColor = color
        print(article)
        let imageViewContainer = UIView()
        self.contentView.addSubview(imageViewContainer)

        imageViewContainer.heightAnchor.constraint(equalToConstant: 250).isActive = true
        imageViewContainer.translatesAutoresizingMaskIntoConstraints = false
        imageViewContainer.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        imageViewContainer.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        imageViewContainer.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true

        let textViewContainer = UIView()
        self.contentView.addSubview(textViewContainer)
//        textViewContainer.heightAnchor.constraint(equalToConstant: 250).isActive = true
        textViewContainer.translatesAutoresizingMaskIntoConstraints = false
        textViewContainer.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        textViewContainer.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        textViewContainer.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 250).isActive = true
        textViewContainer.heightAnchor.constraint(equalToConstant: 100).isActive = true

        let imageView = UIImageView()
        imageView.downloaded(from: article.image, contentMode: .scaleToFill)
        imageView.blur()
        imageViewContainer.addSubview(imageView)
        imageViewContainer.stretchToSuperview(imageView)

        let imageView2 = UIImageView()
        imageView2.downloaded(from: article.image, contentMode: .scaleAspectFit)
        imageViewContainer.addSubview(imageView2)
        imageViewContainer.stretchToSuperview(imageView2)

        let label = UILabel()
        label.text = article.title
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 3
        label.font = .systemFont(ofSize: 20, weight: .medium)
        textViewContainer.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: screenwidth-20).isActive = true
        label.leadingAnchor.constraint(equalTo: textViewContainer.leadingAnchor, constant: 10).isActive = true
        label.topAnchor.constraint(equalTo: textViewContainer.topAnchor, constant: 5).isActive = true
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.centerYAnchor.constraint(equalTo: textViewContainer.centerYAnchor).isActive = true
        self.dropShadow(color: reversedColor, opacity: 1, offSet: CGSize(width: -1, height: 2), radius: 5, scale: true)
    }
    
    func nothingToShow() {
        let label = UILabel()
        label.text = "Статей за вашими темами та сайтами не знайдено. \n Змініть ці налаштування вище та оновіть сторінку свайпом вниз."
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 5
        label.font = .systemFont(ofSize: 15, weight: .regular)
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: screenwidth-20).isActive = true
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        label.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    override func prepareForReuse() {
        self.contentView.subviews.forEach {
            $0.removeFromSuperview()
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if #available(iOS 13.0, *) {
            let hasUserInterfaceStyleChanged = previousTraitCollection?.hasDifferentColorAppearance(comparedTo: traitCollection)
            if let hasUserInterfaceStyleChanged = hasUserInterfaceStyleChanged {
                if hasUserInterfaceStyleChanged {
                    self.backgroundColor = dynamicColor
                    self.dropShadow(color: dynamicColorReversed, opacity: 1, offSet: CGSize(width: -1, height: 2), radius: 5, scale: true)
                }
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
