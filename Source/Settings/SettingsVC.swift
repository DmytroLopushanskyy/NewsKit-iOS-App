//
//  SettingsVC.swift
//  NewsKit-iOS-App
//
//  Created by Oleh Mykytyn on 10/4/19.
//  Copyright © 2019 OlehTyzhai. All rights reserved.
//

import UIKit
import SafariServices


extension Date {
func dateStringWith(strFormat: String) -> String {
       let dateFormatter = DateFormatter()
       dateFormatter.timeZone = Calendar.current.timeZone
       dateFormatter.locale = Calendar.current.locale
       dateFormatter.dateFormat = strFormat
       return dateFormatter.string(from: self)
    }
}

class SettingsVC: UITableViewController, UITextFieldDelegate, SFSafariViewControllerDelegate {
    
    // MARK: - Properties
    var coordinator: AppCoordinator!
    private var datePicker:  UIDatePicker?
    var pickerState = false
    var tapGesture: UITapGestureRecognizer?
    // MARK: - IBOutlets
    @IBOutlet weak var inputTimeField: UITextField!

    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .time
        datePicker?.locale = Locale(identifier: "UA")
        datePicker?.timeZone = TimeZone.autoupdatingCurrent
        
        datePicker?.addTarget(self, action: #selector(SettingsVC.dateChanged(dataPicker:)), for: .valueChanged)
        inputTimeField.delegate = self
        inputTimeField.inputView = datePicker
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(SettingsVC.viewTapped(gestureRecognizer:)))
        
        coordinator = AppCoordinator.shared
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        view.addGestureRecognizer(self.tapGesture!)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {

        view.removeGestureRecognizer(self.tapGesture!)
    }

    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func dateChanged(dataPicker:UIDatePicker) {
        let date = self.datePicker?.date
        let strTime = date?.dateStringWith(strFormat: "HH:mm")
//        print(strTime)
        inputTimeField.text = String(strTime!)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.selectionStyle = .default
        switch indexPath {
        case [0, 0]:
            cell?.selectionStyle = .none
        case [1,1]:
            coordinator.presentAboutThisAppVC()
        case [2,0]:
            let safariVC = SFSafariViewController(url: URL(string: "https://www.facebook.com/newskitbot/")!)
            self.present(safariVC, animated: true, completion: nil)
            safariVC.delegate = self
        case [2,1]:
            let safariVC = SFSafariViewController(url: URL(string: "https://t.me/newskit_bot")!)
            self.present(safariVC, animated: true, completion: nil)
            safariVC.delegate = self
        case [3,0]:
            User.shared.logout()
            defaults.set("", forKey: "username")
            AppCoordinator.shared.appLoaded = false
            coordinator.presentLogin()
        default:
            return
        }
        tableView.deselectRow(at: indexPath, animated: true)


    }
}

