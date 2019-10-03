//
//  News.swift
//  NewsKit-iOS-App
//
//  Created by Oleh Mykytyn on 9/22/19.
//  Copyright © 2019 OlehTyzhai. All rights reserved.
//

import Foundation

class News {
    var news: [Article]
    init() {
        self.news = []
    }

    func load( url: URL, userCompletionHandler: @escaping (Array<Article>, Error?) -> Void) {
        // procesing API requests and loading the news
        var result: [Article] = []
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if error != nil {
                print(error!)
            } else {
                guard let data = data else {return}
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    if let recipe = json as? [String: Any] {
                        if let articles = recipe["lastnews"] as? NSArray {
                            for article in articles as NSArray as! [NSDictionary] {
                                guard let url = article["url"] as? String else {continue}
                                guard let title = article["title"] as? String else {continue}
                                guard let description = article["description"] as? String else {continue}
                                guard let image = article["image"] as? String else {continue}
                                guard let keywords = article["keywords"] as? String else {continue}
                                guard let website = article["website"] as? String else {continue}

                                result.append(Article(url: url, title: title, description: description, image: image, keywords: keywords, website: website))
                            }
                            userCompletionHandler(result, nil)
                        }
                    }
                } catch {
                    print("Json Loading Failed")
                }
            }
        }
        task.resume()
    }
}


