//
//  NewsDataManager.swift
//  NewsKit-iOS-App
//
//  Created by Олег on 02.10.2019.
//  Copyright © 2019 OlehTyzhai. All rights reserved.
//

import UIKit

public class DataManager {
    static let shared = DataManager()
    var delegate: DataManagerDelegate?
    
    func loadNews(userID: Int) -> Void {
        
    }


}

protocol DataManagerDelegate: DataManager {
    func didNewsLoad()
}
