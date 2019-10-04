//
//  SignInViewController.swift
//  NewsKit-iOS-App
//
//  Created by Олег on 04.10.2019.
//  Copyright © 2019 OlehTyzhai. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    @IBOutlet weak var login: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func signInPressed(_ sender: Any) {
        print("pressed")
        if login?.text == nil || password?.text == nil {
            print("1")
            return
        } else {
            AppCoordinator.shared.presentLoading()
            print("2")
            APIhandler.shared.signIn(username: login.text!, password: password.text!) {
                print("signin callback")
            }
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()

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
