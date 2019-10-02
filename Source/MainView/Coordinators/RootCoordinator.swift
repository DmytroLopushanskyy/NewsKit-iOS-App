//
//  RootCoordinator.swift
//  lecture8
//
//  Created by Viktor Malieichyk on 26.09.2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class RootCoordinator: CoordinatableController {
    var coordinator: AppCoordinator!
    let window: UIWindow

    init(_ window: UIWindow) {
        self.window = window

        let navigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NavigationController") as! UINavigationController

        _ = navigationController.view
        navigationController.viewControllers.forEach {
            let navigation = $0 as? UINavigationController
            var controller = navigation?.viewControllers.first as? CoordinatableController
            controller?.coordinator = AppCoordinator()
        }

        window.rootViewController = navigationController
    }

    func present() {
        window.makeKeyAndVisible()
    }
}
