//
//  AppCoordinator.swift
//  lecture8
//
//  Created by Viktor Malieichyk on 25.09.2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class AppCoordinator {
    var navigationController: UINavigationController?

    func presentNewsViewController() {
        let controller = UIStoryboard(name: "Topics", bundle: nil).instantiateViewController(withIdentifier: "TopicsTableViewController") as! TopicsTableViewController
        print("here")

        self.navigationController?.pushViewController(controller, animated: true)
    }

}
