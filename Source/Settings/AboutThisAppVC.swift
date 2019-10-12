//
//  AboutThisAppVC.swift
//  NewsKit-iOS-App
//
//  Created by Oleh Mykytyn on 10/4/19.
//  Copyright © 2019 OlehTyzhai. All rights reserved.
//

import UIKit

class AboutThisAppVC: UIViewController {

    @IBOutlet weak var aboutTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        aboutTextView.text = "Contributors:\n Dmytro Lopushanskyy\n Oleh Mykytyn\n Oleh Tyzhai"
    }

}
