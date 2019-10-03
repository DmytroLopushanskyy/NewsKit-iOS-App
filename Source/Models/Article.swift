//
//  Article.swift
//  NewsKit-iOS-App
//
//  Created by Олег on 03.10.2019.
//  Copyright © 2019 OlehTyzhai. All rights reserved.
//

import Foundation


struct ArticleData {
    var url, title, description, image, keywords, website: String
    
    enum CodingKeys: String, CodingKey{
        case url = "url"
        case title = "title"
        case description = "description"
        case image = "image"
        case keywords = "keywords"
        case website = "website"
    }
}

extension ArticleData: Decodable{
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.url = try container.decode(String.self, forKey: .url)
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decode(String.self, forKey: .description)
        self.image = try container.decode(String.self, forKey: .image)
        self.keywords = try container.decode(String.self, forKey: .keywords)
        self.website = try container.decode(String.self, forKey: .website)

    }
}
