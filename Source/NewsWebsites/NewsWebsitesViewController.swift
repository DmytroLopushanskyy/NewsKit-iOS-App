//
//  NewsWebsitesViewController.swift
//  NewsKit-iOS-App
//
//  Created by Oleh Mykytyn on 9/20/19.
//  Copyright © 2019 OlehTyzhai. All rights reserved.
//

import UIKit

class NewsWebsitesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var arr: [String] = ["5  канал", "newsone"]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        cell.label? .text = arr[indexPath.row]
        return cell
    }
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.register(TableViewCell.self, forCellReuseIdentifier: "Cell")
        // Do any additional setup after loading the view.
    }

    /*t
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
