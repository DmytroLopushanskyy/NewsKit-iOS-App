//
//  Article.swift
//  NewsKit-iOS-App
//
//  Created by Oleh Mykytyn on 9/22/19.
//  Copyright © 2019 OlehTyzhai. All rights reserved.
//

import Foundation


class Struct {
    var url, title, description, image, keywords, website: String;
    init(url:String, title:String, description:String, image:String, keywords:String, website:String) {
        self.url = url;
        self.title = title;
        self.description = description;
        self.image = image;
        self.keywords = keywords;
        self.website = website;
    }
}
