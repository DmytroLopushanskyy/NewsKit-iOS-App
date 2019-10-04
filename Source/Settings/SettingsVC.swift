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
    }}

class SettingsVC: UITableViewController {
    
    @IBOutlet weak var inputTimeField: UITextField!
    private var datePicker:  UIDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .time
        datePicker?.locale = Locale(identifier: "UA")
        datePicker?.timeZone = TimeZone.autoupdatingCurrent
        
        datePicker?.addTarget(self, action: #selector(SettingsVC.dateChanged(dataPicker:)), for: .valueChanged)
        inputTimeField.inputView = datePicker

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SettingsVC.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
    }
    

    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func dateChanged(dataPicker:UIDatePicker) {
        let date = self.datePicker?.date
//        let strTime = date?.dateStringWith(strFormat: "hh:mm a")
        let strTime = date?.dateStringWith(strFormat: "HH:mm")
//        print(strTime)
        inputTimeField.text = String(strTime!)
    }
}

