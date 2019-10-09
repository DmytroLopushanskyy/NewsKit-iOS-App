//
//  user.swift
//  NewsKit-iOS-App
//
//  Created by Дмитро Лопушанський on 10/4/19.
//  Copyright © 2019 OlehTyzhai. All rights reserved.
//

import Foundation

//struct UserSignUp {
//    let name: String
//    let username: String
//}
//let userSignedUp = [UserSignUp]()
//
//func parseJSON(data: Data){
//    do {
//        let decoder = JSONDecoder()
//        decoder.keyDecodingStratergy = .convertFromSnakeCase
//        self.people = try decoder.decode([Person].self, from: data)
//    } catch let error {
//        print(error as? Any)
//    }
//}

//extension NewsData: Decodable {
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.news = try container.decode([ArticleData].self, forKey: .news)
//    }
//}

class User {
    static var shared = User()
    
    var name = ""
    var username = ""
    var newsToSendID = [String]()
    var newsToSendArticle = [ArticleData]()
    var topics = [String]()
    var notificationTime = "12:00"
    var websites = [String]()
    var language = ""
    
    func logout() {
        self.name = ""
        self.username = ""
        self.newsToSendID = [String]()
        self.newsToSendArticle = [ArticleData]()
        self.topics = [String]()
        self.notificationTime = "12:00"
        self.websites = [String]()
        self.language = ""
    }
}
//extension User: Decodable{
//    init(from decoder: Decoder) throws {
//        self.name = try decoder.decode(String.self, forKey: .url)
////        self.title = try decoder.decode(String.self, forKey: .title)
////        self.description = try decoder.decode(String.self, forKey: .description)
////        self.image = try decoder.decode(String.self, forKey: .image)
////        self.keywords = try decoder.decode(String.self, forKey: .keywords)
////        self.website = try decoder.decode(String.self, forKey: .website)
//
//    }
//}
