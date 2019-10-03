//
//  CollectionViewController.swift
//  NewsKit3
//
//  Created by Дмитро Лопушанський on 9/30/19.
//  Copyright © 2019 DmytroLopushanskyy. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"
private let reuseIdentifierForLabelCell = "LabelCell"
private let reuseIdentifierForNewsCell = "NewsCell"

class MainScreenCollectionVC: UICollectionViewController {
    var newsList: [Article] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(CellContainingTableVC.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifierForLabelCell)
        self.collectionView!.register(NewsCell.self, forCellWithReuseIdentifier: reuseIdentifierForNewsCell)

        if let layout = collectionView.collectionViewLayout as?  UICollectionViewFlowLayout {
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            layout.scrollDirection = .vertical
        }

        self.navigationController?.navigationBar.setBackgroundImage(UIColor.white.image(), for: .default)
        self.navigationController?.navigationBar.tintColor = UIColor(red: 181.0/255, green: 181.0/255, blue: 181.0/255, alpha: 1)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.title = "John Doe"
        self.navigationController?.navigationBar.shadowImage = UIColor.white.image()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: ScrollViewDelegate

//    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let offsetY = collectionView.contentOffset.y
//        let navigationBarHeight = self.navigationController?.navigationBar.frame.size.height
//        if offsetY > 100 {
//            self.collectionView.contentInset = UIEdgeInsets(top: navigationBarHeight ?? 0, left: 0, bottom: 0, right: 0)
//            self.navigationController?.setNavigationBarHidden(true, animated: true)
//
//        }
//        if offsetY < 100 {
//            //self.collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//            self.navigationController?.setNavigationBarHidden(false, animated: true)
//        }
//    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        switch indexPath.row {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CellContainingTableVC

            cell.configureCell()
            cell.addViewController(collectionView: self)
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierForLabelCell, for: indexPath)

            cell.subviews.forEach {
                $0.removeFromSuperview()
            }

            let label = UILabel()
            label.text = "Your recent news:"
            label.font = .boldSystemFont(ofSize: 20)

            cell.addSubview(label)

            label.translatesAutoresizingMaskIntoConstraints = false
            label.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
            label.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 20).isActive = true

            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierForNewsCell, for: indexPath) as! NewsCell
            cell.configureCell(collectionView: self, article: newsList[indexPath.row-2])

            return cell
        }
    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return .zero
//    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

extension MainScreenCollectionVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenwidth = UIScreen.main.bounds.width

        switch indexPath.row {
        case 0:
            return CGSize(width: screenwidth, height: 150)
        case 1:
            return CGSize(width: screenwidth, height: 30)
        default:
            return CGSize(width: screenwidth, height: 350)
        }

    }
}

extension UIImage {
    class func imageWithColor(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        defer { UIGraphicsEndImageContext() }

        color.setFill()
        UIRectFill(CGRect(origin: .zero, size: size))

        return UIGraphicsGetImageFromCurrentImageContext()!
    }
}

extension UIColor {
    func image() -> UIImage {
        return UIImage.imageWithColor(color: self)
    }
}