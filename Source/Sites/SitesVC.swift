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
    var sitesStr:String = "Wylsacom, Телеканал 24, AIN.UA, AppleInsider.ru, DOU, Українська Правда, Факти ICTV, Hromadske.ua, Korrespondent, 112.ua, iSport.ua, Spiegel, BBC US, The Verge, The Guardian, New York Times, Techradar, Android Police, 9to5Mac, Lviv1256, B.Z. Berlin, Unian, 5 Канал, Zaxid.Net, TexTerra, LABA, 032.ua Сайт Львова, MC Today, Львівський портал, LB.ua, РБК-Україна, MediaLab, The Village UA, ZIK.UA, Navsi100, Music Ukraine, Womo, Телеканал M1, Futurism, Harvard Business Review, lviv.com, ВЖЕ, BBC Україна, Tproger, proglib, 4PDA, Keddr, Rozetked, GaGadget, notebookcheck, Andro News, Новое Время, Тиждень UA, Дзеркало Тижня"
    
    var sites: [siteCell] = []
    var selectedOptions: [String] = []

        override func viewDidLoad() {
            super.viewDidLoad()
            let listSites = sitesStr.components(separatedBy: ", ")
            for site in listSites {
                sites.append(siteCell(name: site))
            }
            for site_id in User.shared.websites {
                self.selectedOptions.append(String(Int(site_id)! - 1))
            }
            
            
            self.title = "Медіа-джерела"
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
                selectedOptions.append(String(indexPath.row))
            }
            if selectedOptions.contains(String(indexPath.row)) {
                sites[indexPath.row].selected = true
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
                selectedOptions = selectedOptions.filter { $0 != String(indexPath.row) }
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
                selectedOptions = selectedOptions.filter { $0 != String(indexPath.row) }
                User.shared.websites = User.shared.websites.filter { $0 != String(indexPath.row) }
            } else {
                cell?.accessoryType = .checkmark
                sites[indexPath.row].selected = true
                User.shared.websites.append(String(indexPath.row))
            }
            tableView.deselectRow(at: indexPath, animated: true)
            
            APIhandler.shared.changeWebsite(website: indexPath.row + 1)
        }
}
