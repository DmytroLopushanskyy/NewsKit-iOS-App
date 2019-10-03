//
//  NewsRepository.swift
//  NewsKit-iOS-App
//
//  Created by Олег on 03.10.2019.
//  Copyright © 2019 OlehTyzhai. All rights reserved.
//

import Foundation

class Repository {
    static let shared = Repository()

    func getNews(callback: ([News]) -> Void) {
        NewsLoader.shared.loadGlobal(userID: _) {

            let news =  load from base
            callback(news)
        }
    }
}
