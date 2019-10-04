//
//  SettingsVC.swift
//  NewsKit-iOS-App
//
//  Created by Oleh Mykytyn on 10/4/19.
//  Copyright © 2019 OlehTyzhai. All rights reserved.
//

import UIKit

extension Date {
func dateStringWith(strFormat: String) -> String {
       let dateFormatter = DateFormatter()
       dateFormatter.timeZone = Calendar.current.timeZone
       dateFormatter.locale = Calendar.current.locale
       dateFormatter.dateFormat = strFormat
       return dateFormatter.string(from: self)
    }
}

class SettingsVC: UITableViewController, UITextFieldDelegate {
    var coordinator: AppCoordinator! {
        didSet {
            coordinator.navigationController = navigationController!
        }
    }
    
    @IBOutlet weak var inputTimeField: UITextField!
    private var datePicker:  UIDatePicker?
    var pickerState = false
    var tapGesture: UITapGestureRecognizer?
    
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
        
        
        let navController = UINavigationController()
        coordinator = AppCoordinator(with: navController)
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
        switch  indexPath.section{
        case 0:
            return
        case 1:
            switch indexPath.row {
            case 0:
                return
            case 1:
                coordinator.presentAboutThisAppVC()
            case 2:
                coordinator.presentAboutThisAppVC()

            default:
                return
            }
        default:
            return
        }
        
        
    }
}

