//
//  SignUpViewController.swift
//  NewsKit-iOS-App
//
//  Created by Олег on 04.10.2019.
//  Copyright © 2019 OlehTyzhai. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, CoordinatableController {
    @IBOutlet weak var login: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var fullname: UITextField!
    
    var coordinator: AppCoordinator!
    
    @IBAction func signUpPressed(_ sender: Any) {
        print("pressed")
        if login?.text == nil || password?.text == nil || fullname?.text == nil {
            print("1")
            return
        } else {
            AppCoordinator.shared.presentLoading()
            print("2")
            APIhandler.shared.signUp(username: login.text!, password: password.text!, fullname: fullname.text!)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        let navController = coordinator.navigationController
//        coordinator = AppCoordinator(with: navigationController!)
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
