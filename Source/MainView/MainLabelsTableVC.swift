//
//  TableViewController.swift
//  NewsKit3
//
//  Created by Дмитро Лопушанський on 9/30/19.
//  Copyright © 2019 DmytroLopushanskyy. All rights reserved.
//

import UIKit

protocol CoordinatableController {
    var coordinator: AppCoordinator! { get set }
}

class MainLabelsTableVC: UITableViewController, CoordinatableController {
    var coordinator: AppCoordinator! {
        didSet {
            coordinator.navigationController = navigationController!
            print("hurray")
        }
    }

    var labeLTitles = ["News", "Web Sources", "Keywords & Topics"]
    var imageNames = ["news2.png", "web2.png", "keywords2.png" ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        let navController = UINavigationController()
        coordinator = AppCoordinator(with: navigationController!)

        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "tableViewCell")

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath)

        cell.subviews.forEach {
            $0.removeFromSuperview()
        }

        let label = UILabel()
        cell.addSubview(label)
        cell.accessoryType = .disclosureIndicator
        cell.tintColor = UIColor.init(red: 212, green: 212, blue: 212, alpha: 1)

        let iconName = imageNames[indexPath[1]]
        let icon = UIImage(named: iconName)
        let imageView = UIImageView(frame: CGRect(x: 20, y: 7, width: 36, height: 36))
        imageView.image = icon

        cell.addSubview(imageView)

        label.text = labeLTitles[indexPath[1]]
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 76).isActive = true

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }

    // MARK: Table View Delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            coordinator.presentArticleViewController()
        case 1:
            coordinator.presentSitesViewController()
        default:
            coordinator.presentTopicsViewController()
        }
    }

}
