//
//  NewsStorage.swift
//  NewsKit-iOS-App
//
//  Created by Олег on 03.10.2019.
//  Copyright © 2019 OlehTyzhai. All rights reserved.
//

import Foundation

class NewsStorage {
    static let shared = NewsStorage()
    
    var news = [ArticleData]()
    
    func sync() {
        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "synced")))
    }
}
