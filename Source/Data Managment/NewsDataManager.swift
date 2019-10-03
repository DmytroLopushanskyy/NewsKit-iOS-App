//
//  NewsDataManager.swift
//  NewsKit-iOS-App
//
//  Created by Олег on 02.10.2019.
//  Copyright © 2019 OlehTyzhai. All rights reserved.
//

import UIKit

public class DataManager {
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    func uploadDataFromAPI(userID: Int) {
        var result: [Artticle] = []
        let str = "http://newskit.pythonanywhere.com/api/getlastnews?user=\(userID)"
        let url = URL(string: str)!
        let group = DispatchGroup()
        group.enter()
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if error != nil {
                print(error!)
            } else {
                guard let data = data else { return }
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    if let recipe = json as? [String: Any] {
                        if let articles = recipe["lastnews"] as? NSArray {
                            for article in articles as NSArray as! [NSDictionary] {
                                guard let url = article["url"] as? String else { continue }
                                guard let title = article["title"] as? String else { continue }
                                guard let description = article["description"] as? String else { continue }
                                guard let image = article["image"] as? String else { continue }
                                guard let keywords = article["keywords"] as? String else { continue }
                                guard let website = article["website"] as? String else { continue }
                                let data = Article(url: url, title: title, description: description, image: image, keywords: keywords, website: website)
                                let article = Artticle(entity: Artticle.entity(), insertInto: self.context)
                                article.decriptionTextt = data.description
                                article.imageUrl = data.image
                                article.keywords = data.keywords
                                article.sourceUrl = data.website
                                article.tittle = data.title
                                article.url = data.url
                                self.appDelegate.saveContext()
                                result.append(article)
                                        group.enter()

                            }

                        }
                    }
                } catch {
                    print("Json Loading Failed")
                }
            }
        }
        task.resume()
        group.wait()
    }

}
