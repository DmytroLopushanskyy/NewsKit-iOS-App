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
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()

    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    deinit {
        print("deallocing \(self)")
    }

    func start() {
        //login or register
        //show loading Storyboard
        //data loading
        //when finished:
        presentMainViewController()
        
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
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CollectionController") as! MainScreenCollectionVC
        
        let group = DispatchGroup()
        group.enter()
        let news = News()
        var newsList: [Article] = []
        news.load(url: URL(string: "http://newskit.pythonanywhere.com/api/getlastnews?user=138918380")!) { (result, _) in
            newsList = result
            group.leave()
        }
        group.wait()
        
        controller.newsList = newsList

        self.navigationController.pushViewController(controller, animated: true)
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
    
}
