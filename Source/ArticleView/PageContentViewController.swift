//
//  PageContentViewController.swift
//  NewsKit
//
//  Created by Олег on 01.10.2019.
//  Copyright © 2019 OlehTyzhai. All rights reserved.
//

import UIKit

class PageContentViewController: UIViewController {
    var index: Int = 0
    var article: ArticleData?
    var result: [ArticleData] = []
    var image: UIImage?
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var desc: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.layer.cornerRadius = 30
        if let imageUrl = article?.image {
            let url = URL(string: imageUrl)!
            self.image = try? UIImage(data: Data(contentsOf: url))

        }
    }
        
    override func viewWillAppear(_ animated: Bool) {
        textLabel.text = article?.title
        desc.text = article?.description
        if let image = self.image {
            img.image = image
            img.backgroundColor = UIColor(patternImage: image)
            view.backgroundColor = UIColor(patternImage: image)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
