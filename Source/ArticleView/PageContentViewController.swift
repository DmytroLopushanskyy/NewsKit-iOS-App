//
//  PageContentViewController.swift
//  NewsKit
//
//  Created by Олег on 01.10.2019.
//  Copyright © 2019 OlehTyzhai. All rights reserved.
//

import UIKit
import SafariServices

class PageContentViewController: UIViewController,SFSafariViewControllerDelegate {
    var index: Int = 0
    var article: ArticleData?
    var result: [ArticleData] = []
    var image: UIImage?
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var closeWindowButton: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var readMoreButton: UIButton!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBAction func readMoreTapped(_ sender: Any) {
        let safariVC = SFSafariViewController(url: URL(string: article!.url)!)
        self.present(safariVC, animated: true, completion: nil)
        safariVC.delegate = self
    }
    
    
    @IBAction func onCloseButton(_ sender: Any) {
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let tap = UIGestureRecognizer(target: self, action: #selector(self.closeWindow(_:)))
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.closeWindow(_:)))
        closeWindowButton.addGestureRecognizer(tap)
//        closeWindowButton.isUserInteractionEnabled = true
//        NotificationCenter.default.addObserver(self, selector: #selector(windowOrientationChange), name: NSNotification.Name., object: <#T##Any?#>)
        contentView.layer.cornerRadius = 30
        readMoreButton.layer.cornerRadius = 15
        if let imageUrl = article?.image {
            if let url = URL(string: imageUrl){
                
                DispatchQueue.global().async {
                    self.image = try? UIImage(data: Data(contentsOf: url))
                    if let image = self.image {
                        DispatchQueue.main.async {
                            self.img.image = self.image
                            self.img.backgroundColor = UIColor(patternImage: self.image!.blurEffect())
                        }
                    } else {
                        
                    }
                    
                    
                }
                
                
            }

        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
    }
    
    @objc func closeWindow(_ sender: UITapGestureRecognizer){
        print("close")
//        self.navigationController?.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func windowOrientationChange(){
        
    }
        
    override func viewWillAppear(_ animated: Bool) {
        textLabel.text = article?.title
        desc.text = article?.description
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
