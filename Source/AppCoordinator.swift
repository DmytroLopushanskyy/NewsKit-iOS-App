//
//  AppCoordinator.swift
//  lecture8
//
//  Created by Viktor Malieichyk on 25.09.2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import CryptoSwift

class Coordinator { }

let defaults = UserDefaults.standard

class AppCoordinator {
    static let shared = AppCoordinator()
    var appLoaded = false
    
    private(set) var navigationController = UINavigationController()
    var window: UIWindow! {
        didSet {
            window.rootViewController = navigationController
        }
    }

    deinit {
        print("deallocing \(self)")
    }

    func start() {
        
        do {
            let encryptedUsername = defaults.string(forKey: "username")
            if let encryptedUsername = encryptedUsername {
                if encryptedUsername != "" {
                    presentLoading()
                    print(encryptedUsername)
                    let decoded = try decodeHash(for: encryptedUsername)
                    print("Username decoded:", decoded)
                    
                   
                    APIhandler.shared.signIn(username: decoded, password: "f2f61#%03e771e4&(76cc2e75f3*%3891e2b8c)")
                } else {
                    print("username in User Defaults is empty string!")
                    presentLogin()
                }
            } else {
                print("no username in User Defaults")
                presentLogin()
            }
        } catch {
            print("error", error)
            print("else login")
            presentLogin()
        }
    }

    func presentTopicsViewController() {
        let controller = UIStoryboard(name: "Topics", bundle: nil).instantiateViewController(withIdentifier: "TopicsTableViewController") as! TopicsTableVC

        print(controller.selectedOptions)
        var selectedOptions = [Int]()
        controller.categories.enumerated().forEach { (offset, cellData) in
            if User.shared.topics.contains(cellData.name.lowercased()) {
                selectedOptions.append(offset)
            }
        }
        
        controller.selectedOptions = selectedOptions

        self.navigationController.pushViewController(controller, animated: true)
    }

    func presentMainViewController() {
        print("presenting main")
        Repository.shared.getNews(forceReloadDataFromAPI: true)
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

    func presentArticleViewController(index: Int = 0) {
        let controller = UIStoryboard(name: "Article", bundle: nil).instantiateViewController(withIdentifier: "ArticleVC") as! PageViewController
        controller.startIndex = index
        //self.navigationController.present(controller, animated: true, completion: nil)
        self.navigationController.pushViewController(controller, animated: true)
    }
    
    func presentSettingsViewController() {
        let controller = UIStoryboard(name: "Settings", bundle: nil).instantiateViewController(withIdentifier: "SettingsSB") as! SettingsVC
        let nav = self.navigationController //grab an instance of the current navigationController
        DispatchQueue.main.async { //make sure all UI updates are on the main thread.
            nav.view.layer.add(CATransition().segueFromLeft(), forKey: nil)
            nav.pushViewController(controller, animated: false)
        }
        //self.navigationController.pushViewController(controller, animated: true)
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
        window?.rootViewController = controller
        self.navigationController.present(controller, animated: true, completion: nil)
    }
    
    func presentLoading() {
        let controller = UIStoryboard(name: "Loading", bundle: nil).instantiateViewController(withIdentifier: "Loading")
        controller.modalPresentationStyle = .fullScreen
        window?.rootViewController = AppCoordinator.shared.navigationController
        window.makeKeyAndVisible()
        controller.modalTransitionStyle = .crossDissolve
        self.navigationController.present(controller, animated: true, completion: nil)
    }

    func presentAfterLoginSitesViewController() {
        let controller = UIStoryboard(name: "Sites", bundle: nil).instantiateViewController(withIdentifier: "SitesVC") as! SitesVC
        controller.setUpAfterSignUp()
        
        self.navigationController.pushViewController(controller, animated: true)
        self.navigationController.dismiss(animated: true, completion: nil)
    }
    
    func presentAfterLoginTopicsViewController() {
        let controller = UIStoryboard(name: "Topics", bundle: nil).instantiateViewController(withIdentifier: "TopicsTableViewController") as! TopicsTableVC
        controller.setUpTopicsAfterSignUp()


        self.navigationController.pushViewController(controller, animated: true)
        self.navigationController.dismiss(animated: true, completion: nil)    }
}
