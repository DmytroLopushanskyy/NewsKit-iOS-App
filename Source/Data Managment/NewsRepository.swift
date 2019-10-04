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
            print("Data from current session")
            NewsStorage.shared.sync()
        } else if !CoreStorage.shared.isEmpty() {
            print("Data from Core Storage")
            NewsLoader.shared.loadLocal(userID: userID)
            NewsStorage.shared.sync()
        }else{
            print("Data from API")
            NewsLoader.shared.loadGlobal(userID: userID) {
                NewsStorage.shared.sync()
            }
        }

    }
}

protocol RepositoryDelegate: Repository {
    func didDataLoaded()
}
