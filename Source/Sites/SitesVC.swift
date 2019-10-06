//
//  SitesVC.swift
//  NewsKit-iOS-App
//
//  Created by Oleh Mykytyn on 10/4/19.
//  Copyright © 2019 OlehTyzhai. All rights reserved.
//

import Foundation
import UIKit

struct siteCell {
    let name: String
    var selected: Bool = false
}


class SitesVC: UITableViewController {
    var sitesStr:String = "Телеканал 24, Korrespondent, AIN.UA, 9to5Mac, Львівський портал, TexTerra, BBC Україна, GaGadget, Android Police, AppleInsider.ru, Womo, lviv.com, 4PDA, Rozetked, 5 Канал, 032.ua Сайт Львова, The Verge, РБК-Україна, MC Today, Lviv1256, Дзеркало Тижня, Факти ICTV, iSport.ua, Harvard Business Review, Tproger, ZIK.UA, Zaxid.Net, Українська Правда, Wylsacom, Techradar, The Guardian, LABA, 112.ua, Новое Время, LB.ua, Hromadske.ua, proglib, The Village UA, New York Times, DOU, Andro News, BBC US, Navsi100, B.Z. Berlin, Spiegel, Futurism, MediaLab, Music Ukraine, Unian, notebookcheck, ВЖЕ, Keddr, Тиждень UA, Телеканал M1"
    
    var sites: [siteCell] = []
    var selectedOptions: [Int] = []

        override func viewDidLoad() {
            super.viewDidLoad()
            let listSites = sitesStr.components(separatedBy: ", ")
            for site in listSites {
                sites.append(siteCell(name: site))
            }
            
            
            self.title = "Web Sources"
            self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        }

        // MARK: - Table view data source

        override func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }

        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return sites.count
        }

        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel?.text = sites[indexPath.row].name
            cell.tintColor = UIColor.red
            if sites[indexPath.row].selected {
                cell.accessoryType = .checkmark
                selectedOptions.append(indexPath.row)
            }
            if selectedOptions.contains(indexPath.row) {
                sites[indexPath.row].selected = true
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
            if sites[indexPath.row].selected {
                cell?.accessoryType = .none
                sites[indexPath.row].selected = false
                selectedOptions = selectedOptions.filter { $0 != indexPath.row }
            } else {
                cell?.accessoryType = .checkmark

                sites[indexPath.row].selected = true
            }
            tableView.deselectRow(at: indexPath, animated: true)
        }
}
