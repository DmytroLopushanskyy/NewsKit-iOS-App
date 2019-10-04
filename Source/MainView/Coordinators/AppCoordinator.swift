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
        var logged_in = false
        if !logged_in {
            
        }
        Repository.shared.getNews()
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
        let selectedOptions = [1, 2, 5]
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
            let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CollectionController") as! MainScreenCollectionVC
            controller.newsList = NewsStorage.shared.news
            self.navigationController.pushViewController(controller, animated: true)
            self.navigationController.dismiss(animated: true, completion: nil)
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
