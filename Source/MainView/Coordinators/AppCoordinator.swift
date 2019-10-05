//
//  AppCoordinator.swift
//  lecture8
//
//  Created by Viktor Malieichyk on 25.09.2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

//class AppCoordinator {
//    var navigationController: UINavigationController?
//
//    func presentNewsViewController() {
//        let controller = UIStoryboard(name: "Topics", bundle: nil).instantiateViewController(withIdentifier: "TopicsTableViewController") as! TopicsTableViewController
//
//        self.navigationController?.pushViewController(controller, animated: true)
//    }
//
//}

class Coordinator { }

class AppCoordinator {
    static let shared = AppCoordinator()
    var appLoaded = false
    
    private(set) var navigationController = UINavigationController()
    var window: UIWindow! {
        didSet {
            window.rootViewController = navigationController
        }
    }
    //var tabBarController: UITabBarController

//    init(with navigationController: UINavigationController) {
//        self.navigationController = navigationController
//    }
//    init(with tabBarController: UITabBarController) {
//        self.tabBarController = tabBarController
//    }

    deinit {
        print("deallocing \(self)")
    }

    func start() {
        Repository.shared.getNews(forceReloadDataFromAPI: true)
        //login or register
        //show loading Storyboard
        //data loading
        //when finished:
        presentLogin()
       //presentMainViewController()
        
        //presentArticleViewController()
    }

    func presentTopicsViewController() {
        let controller = UIStoryboard(name: "Topics", bundle: nil).instantiateViewController(withIdentifier: "TopicsTableViewController") as! TopicsTableVC

        print(controller.selectedOptions)
        var selectedOptions = [Int]()
        controller.categories.enumerated().forEach { (offset, cellData) in
            if User.shared.topics.contains(cellData.name.lowercased()) {
                selectedOptions.append(offset)
            } else {
                if selectedOptions.contains(offset) {
                    selectedOptions.filter { $0 != offset}
                }
            }
        }
        
        
        controller.selectedOptions = selectedOptions

        self.navigationController.pushViewController(controller, animated: true)
    }

    func presentMainViewController() {
        print("presenting main")
        //window?.rootViewController = AppCoordinator.shared.navigationController
        
 
        Repository.shared.getNews()
        NotificationCenter.default.addObserver(self, selector: #selector(dataLoaded2), name: NSNotification.Name(rawValue: "synced"), object: nil)
        
    }
    @objc func dataLoaded2() {
        DispatchQueue.main.async {
            print("data loaded!")
            if !self.appLoaded {
                if User.shared.username == "" {
                    print("False Credentials")
                    self.navigationController.dismiss(animated: true, completion: nil)
                    self.presentLogin()
                    return
                }
                let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CollectionController") as! MainScreenCollectionVC
                controller.newsList = NewsStorage.shared.news
                self.navigationController.pushViewController(controller, animated: true)

                self.navigationController.dismiss(animated: true, completion: nil)
                self.appLoaded = true
            }
        }
    }

    func presentArticleViewController() {
        let controller = UIStoryboard(name: "Article", bundle: nil).instantiateViewController(withIdentifier: "ArticleVC") as! PageViewController

        //self.navigationController.present(controller, animated: true, completion: nil)
        self.navigationController.pushViewController(controller, animated: true)
    }
    
    func presentSettingsViewController() {
        let controller = UIStoryboard(name: "Settings", bundle: nil).instantiateViewController(withIdentifier: "SettingsSB") as! SettingsVC

        self.navigationController.pushViewController(controller, animated: true)
    }
    
    func presentAboutThisAppVC() {
        let controller = UIStoryboard(name: "Settings", bundle: nil).instantiateViewController(withIdentifier: "AboutThisAppVC") as! AboutThisAppVC

        self.navigationController.pushViewController(controller, animated: true)
    }
    
    func presentSitesViewController() {
        let controller = UIStoryboard(name: "Sites", bundle: nil).instantiateViewController(withIdentifier: "SitesVC") as! SitesVC
        
        self.navigationController.pushViewController(controller, animated: true)
    }
    
    func presentRateThisAppViewController() {
        let controller = UIStoryboard(name: "RateThisApp", bundle: nil).instantiateViewController(withIdentifier: "RateThisAppVC") as! RateThisAppVC
        
        self.navigationController.pushViewController(controller, animated: true)
    }
    func presentLogin() {
        let controller = UIStoryboard(name: "sign", bundle: nil).instantiateViewController(withIdentifier: "TabBarVC") as! UITabBarController

        self.navigationController.present(controller, animated: true, completion: nil)
        window?.rootViewController = controller
    }
    
    func presentLoading() {
        let controller = UIStoryboard(name: "Loading", bundle: nil).instantiateViewController(withIdentifier: "Loading")
        controller.modalPresentationStyle = .fullScreen
        window?.rootViewController = AppCoordinator.shared.navigationController
        self.navigationController.present(controller, animated: true, completion: nil)
    }
    
}
