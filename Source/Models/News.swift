//
//  News.swift
//  NewsKit-iOS-App
//
//  Created by Олег on 03.10.2019.
//  Copyright © 2019 OlehTyzhai. All rights reserved.
//

import Foundation

struct NewsData {
    var news: [ArticleData]

    enum CodingKeys: String, CodingKey {
        case news = "lastnews"
    }
}

extension NewsData: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.news = try container.decode([ArticleData].self, forKey: .news)
    }
}
