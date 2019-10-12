//
//  CoreStorage.swift
//  NewsKit-iOS-App
//
//  Created by Олег on 03.10.2019.
//  Copyright © 2019 OlehTyzhai. All rights reserved.
//

import UIKit

class CoreStorage {
    static let shared = CoreStorage()
    var coreNews: [Artticle]!

    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    init() {
        do {
            self.coreNews = try self.context.fetch(Artticle.fetchRequest())
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }

    func isEmpty() -> Bool {
        return self.coreNews.isEmpty
    }

    func getNews() {
        var news: [ArticleData] = []
        do {
            self.coreNews = try self.context.fetch(Artticle.fetchRequest())
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        for item in self.coreNews {
            news.append(ArticleData(url: item.url ?? "", title: item.tittle ?? "", description: item.decriptionTextt ?? "", image: item.imageUrl ?? "", keywords: item.keywords ?? "", website: item.sourceUrl ?? ""))
        }
        NewsStorage.shared.news = news
    }

    func deleteAllNews() {
        for article in self.coreNews {
            context.delete(article)
        }
        coreNews = []
        appDelegate.saveContext()
    }

    func insert(from newsData: [ArticleData]) {
        for articleData in newsData {
            let article = Artticle(entity: Artticle.entity(), insertInto: context)
            article.url = articleData.url
            article.decriptionTextt = articleData.description
            article.imageUrl = articleData.image
            article.keywords = articleData.keywords
            article.sourceUrl = articleData.website
            article.tittle = articleData.title
            appDelegate.saveContext()
            coreNews.append(article)
        }
    }

    func loadNewArticles(from newsData: [ArticleData]) {
        deleteAllNews()
        insert(from: newsData)
    }

}
