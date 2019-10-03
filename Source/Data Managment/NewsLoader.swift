//
//  NewsLoader.swift
//  NewsKit-iOS-App
//
//  Created by Олег on 03.10.2019.
//  Copyright © 2019 OlehTyzhai. All rights reserved.
//

import Foundation

class NewsLoader{
    static let shared = NewsLoader()
    private let decoder = JSONDecoder()
    
    func loadGlobal(userID: Int){
        let urlString = "http://newskit.pythonanywhere.com/api/getlastnews?user=\(userID)"
        let url = URL(string: urlString)!
        let dataTask = URLSession.shared.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if let d = data, d.count > 0 {
                let news = try? self.decoder.decode(NewsData.self, from: d)
                
                NewsStorage.shared.news = news?.news ?? []
                NewsStorage.shared.sync()
            }
        }
        dataTask.priority = 0.9
        dataTask.resume()
    }
}
