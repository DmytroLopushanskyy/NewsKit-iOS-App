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
    func getNews(forceReloadDataFromAPI: Bool = false) {
        let news = NewsStorage.shared.news
        if !news.isEmpty && !forceReloadDataFromAPI {
            print("Data from current session")
            NewsStorage.shared.sync()
        } else if !CoreStorage.shared.isEmpty() && !forceReloadDataFromAPI {
            print("Data from Core Storage")
            NewsLoader.shared.loadLocal()
            NewsStorage.shared.sync()
        }else{
            print("Data from API")
            NewsLoader.shared.loadGlobal() {
                NewsStorage.shared.sync()
            }
        }

    }
}

protocol RepositoryDelegate: Repository {
    func didDataLoaded()
}
