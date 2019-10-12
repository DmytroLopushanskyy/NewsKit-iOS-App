//
//  TableViewController.swift
//  checkbox_test
//
//  Created by Oleh Mykytyn o   n 9/30/19.
//  Copyright © 2019 Oleh Mykytyn. All rights reserved.
//

import UIKit

struct CellData {
    let name: String
    let image: UIImage?
    var selected: Bool = false
}

class TopicsTableVC: UITableViewController {
    var categories: [CellData] = [CellData(name: "Політика", image: UIImage(named: "politics")),
                                CellData(name: "Медицина", image: UIImage(named: "medicine")),
                                CellData(name: "Програмування", image: UIImage(named: "programing")),
                                CellData(name: "Технології", image: UIImage(named: "technology")),
                                CellData(name: "Спорт", image: UIImage(named: "sport")),
                                CellData(name: "Економіка", image: UIImage(named: "economic")),
                                CellData(name: "Події", image: UIImage(named: "events")),
                                CellData(name: "Наука", image: UIImage(named: "science")),
                                CellData(name: "Музика", image: UIImage(named: "music")),
                                CellData(name: "Україна", image: UIImage(named: "ukraine")),
                                CellData(name: "Освіта", image: UIImage(named: "education")),
                                CellData(name: "Погода", image: UIImage(named: "weather")),
                                CellData(name: "Фільми", image: UIImage(named: "films")),
                                CellData(name: "Львів", image: UIImage(named: "lviv")),
                                CellData(name: "Поліція", image: UIImage(named: "police")),
                                CellData(name: "Культура", image: UIImage(named: "culture")),
                                CellData(name: "Соціум", image: UIImage(named: "society"))]
    var selectedOptions: [Int] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Ключові слова & теми"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].name
        cell.imageView?.image = categories[indexPath.row].image
        cell.tintColor = UIColor(red: 220/255, green: 60/255, blue: 60/255, alpha: 1)

        if categories[indexPath.row].selected {
            cell.accessoryType = .checkmark
            selectedOptions.append(indexPath.row)
        }
        if selectedOptions.contains(indexPath.row) {
            categories[indexPath.row].selected = true
            cell.accessoryType = .checkmark

        } else {
            cell.accessoryType = .none
            selectedOptions = selectedOptions.filter { $0 != indexPath.row }
        }
        return cell
    }

    // MARK: - Table View Delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.selectionStyle = .default
        if categories[indexPath.row].selected {
            cell?.accessoryType = .none
            categories[indexPath.row].selected = false
            selectedOptions = selectedOptions.filter { $0 != indexPath.row }
            User.shared.topics = User.shared.topics.filter { $0 != categories[indexPath.row].name.lowercased() }
        } else {
            cell?.accessoryType = .checkmark
            User.shared.topics.append(categories[indexPath.row].name.lowercased())
            categories[indexPath.row].selected = true
        }
        tableView.deselectRow(at: indexPath, animated: true)

        print(categories[indexPath.row].name.lowercased())
        APIhandler.shared.changeTopics(topics: categories[indexPath.row].name)
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }

    @objc func nextClicked(sender: UIBarButtonItem) {
        //APIhandler.
//        AppCoordinator.shared.presentAfterLoginSitesViewController()
        APIhandler.shared.generatedWebsites()
    }
    func setUpTopicsAfterSignUp() {
        self.title = "Оберіть теми"
        self.navigationItem.hidesBackButton = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Далі", style: .done, target: self, action: #selector(self.nextClicked(sender:)))
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
