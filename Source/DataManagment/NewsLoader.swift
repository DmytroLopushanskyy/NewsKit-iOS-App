//
//  NewsLoader.swift
//  NewsKit-iOS-App
//
//  Created by Олег on 03.10.2019.
//  Copyright © 2019 OlehTyzhai. All rights reserved.
//

import UIKit

class NewsLoader {
    static let shared = NewsLoader()
    private let decoder = JSONDecoder()

    func loadGlobal(callback: (() -> Void)? = nil) {
        let urlString = "http://newskit.pythonanywhere.com/api/getlastnews?username=\(User.shared.username)"
        print(urlString)
        if let url = URL(string: urlString) {
            let dataTask = URLSession.shared.dataTask(with: url) { (data: Data?, _: URLResponse?, _: Error?) in
                if let d = data, d.count > 0 {
                    let news = try? self.decoder.decode(NewsData.self, from: d)
                    DispatchQueue.main.async {
                        NewsStorage.shared.news = news?.news ?? []
                        CoreStorage.shared.loadNewArticles(from: NewsStorage.shared.news)
                        callback?()
                    }
                }
            }
            dataTask.priority = 0.9
            dataTask.resume()
        } else {
            NewsStorage.shared.news = []
            callback?()
        }

    }

    func loadLocal() {
        CoreStorage.shared.getNews()
    }
}
