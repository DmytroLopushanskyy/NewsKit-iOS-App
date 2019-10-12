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

class MainScreenCollectionVC: UICollectionViewController,
        CoordinatableController {
    var coordinator: AppCoordinator!
    var refresher: UIRefreshControl!

    @IBAction func settingsTapped(_ sender: Any) {
        coordinator.presentSettingsViewController()
    }

    var newsList: [ArticleData] = []

    @objc func dataLoaded() {
        newsList = NewsStorage.shared.news
        self.collectionView.reloadData()
        self.refresher.endRefreshing()
    }
    func makeRefresher() {
        // adding refresher to application
        refresher = UIRefreshControl()
        self.collectionView.addSubview(refresher)
        refresher.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refresher.tintColor = UIColor(red: 212.0/255, green: 212.0/255, blue: 212.0/255, alpha: 1)
        refresher.addTarget(self, action: #selector(updateData), for: .valueChanged)
    }

    @objc func updateData() {
        print(User.shared.newsToSendID.isEmpty, User.shared.newsToSendID, User.shared.newsToSendArticle)
        if User.shared.newsToSendArticle.isEmpty {
            print("isEmpty")
            APIhandler.shared.generateFirstNews(funcToCallWhenFinished: "autoReload")
        } else {
            Repository.shared.getNews(forceReloadDataFromAPI: true)
        }

    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.tintColor = UIColor.gray
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.tintColor = UIColor(red: 220 / 255, green: 60 / 255, blue: 60 / 255, alpha: 1)
    }

    override func viewDidLoad() {
        makeRefresher()
        super.viewDidLoad()
        collectionView.alwaysBounceVertical = true
        coordinator = AppCoordinator.shared
        NotificationCenter.default.addObserver(self, selector: #selector(dataLoaded), name: NSNotification.Name(rawValue: "synced"), object: nil)
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
        let color: UIColor
        if #available(iOS 13.0, *) {
            color = dynamicColor
        } else {
            color = UIColor.white
        }
    self.navigationController?.navigationBar.setBackgroundImage(color.image(), for: .default)
        self.navigationController?.navigationBar.tintColor = UIColor(red: 181.0/255, green: 181.0/255, blue: 181.0/255, alpha: 1)
        self.navigationController?.navigationBar.tintColor = UIColor.lightGray
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.title = User.shared.name
        self.navigationController?.navigationBar.shadowImage = color.image()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if UIApplication.shared.supportsAlternateIcons {
            if let alternateIconName = UIApplication.shared.alternateIconName {
                print("current icon is \(alternateIconName), change to primary icon")
                UIApplication.shared.setAlternateIconName(nil)
            } else {
                print("current icon is primary icon, change to alternative icon")
                UIApplication.shared.setAlternateIconName("AlternateIcon") { error in
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        print("Done!")
                    }
                }
            }
        }

        if #available(iOS 13.0, *) {
            let hasUserInterfaceStyleChanged = previousTraitCollection?.hasDifferentColorAppearance(comparedTo: traitCollection)
            if let hasUserInterfaceStyleChanged = hasUserInterfaceStyleChanged {
                if hasUserInterfaceStyleChanged {
                    let color = dynamicColor
                self.navigationController?.navigationBar.setBackgroundImage(color.image(), for: .default)
                    self.navigationController?.navigationBar.shadowImage = color.image()
                }
            }
        }
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
        if newsList.count != 0 {
            return newsList.count + 2
        } else {
            return 3
        }
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
            if newsList.isEmpty {
                cell.nothingToShow()
            } else {
                cell.configureCell(collectionView: self, article: newsList[indexPath.row-2])
            }

            return cell
        }
    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return .zero
//    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row > 1 {
            coordinator.presentArticleViewController(index: indexPath.row - 2)
        }
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

func delay(_ delay: Double, closure:@escaping ()->Void) {
    let when = DispatchTime.now() + delay
    DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
}
