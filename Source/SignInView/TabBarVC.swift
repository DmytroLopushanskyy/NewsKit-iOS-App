//
//  TabBarVC.swift
//  NewsKit-iOS-App
//
//  Created by Дмитро Лопушанський on 10/4/19.
//  Copyright © 2019 OlehTyzhai. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController {
    var coordinator: AppCoordinator!

    override func viewDidLoad() {
        super.viewDidLoad()
        coordinator = AppCoordinator.shared
        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
