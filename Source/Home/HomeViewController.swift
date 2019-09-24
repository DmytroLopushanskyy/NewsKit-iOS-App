//
//  ViewController.swift
//  NewsKit-iOS-App
//
//  Created by Олег on 20.09.2019.
//  Copyright © 2019 OlehTyzhai. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBAction func btn(_ sender: Any) {
        let articleStoryboard = UIStoryboard(name: "Article", bundle: nil)
        let articleViewController = articleStoryboard.instantiateViewController(withIdentifier: "Article")
        self.present(articleViewController, animated: true, completion: nil
        )
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}
