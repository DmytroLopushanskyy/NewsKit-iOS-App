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

    func getNews(userID: Int) {
        let news = NewsStorage.shared.news
        if !news.isEmpty {
            print(1)
            NewsStorage.shared.sync()
        } else if !CoreStorage.shared.isEmpty() {
            print(2)
            NewsLoader.shared.loadLocal(userID: userID)
            NewsStorage.shared.sync()
        }else{
            print(3)
            NewsLoader.shared.loadGlobal(userID: userID) {
                NewsStorage.shared.sync()
            }
        }

    }
}
