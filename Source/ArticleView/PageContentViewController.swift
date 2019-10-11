//
//  PageContentViewController.swift
//  NewsKit
//
//  Created by Олег on 01.10.2019.
//  Copyright © 2019 OlehTyzhai. All rights reserved.
//

import UIKit
import SafariServices
import SDWebImage

class PageContentViewController: UIViewController, SFSafariViewControllerDelegate {
    var index: Int = 0
    var article: ArticleData?
    var result: [ArticleData] = []
    var image: UIImage?
    @IBOutlet weak var shareButton: UIView!
    @IBOutlet weak var closeWindowButton: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var readMoreButton: UIButton!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBAction func readMoreTapped(_ sender: Any) {
        let safariVC = SFSafariViewController(url: URL(string: article!.url)!)
        safariVC.transitioningDelegate = self
//        self.navigationController?.pushViewController(safariVC, animated: true)
        self.present(safariVC, animated: true, completion: nil)
        safariVC.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        let tap = UIGestureRecognizer(target: self, action: #selector(self.closeWindow(_:)))
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.closeWindow(_:)))
        let shareTap = UITapGestureRecognizer(target: self, action: #selector(self.shareArticle(_:)))
        shareButton.addGestureRecognizer(shareTap)
        closeWindowButton.addGestureRecognizer(tap)
//        closeWindowButton.isUserInteractionEnabled = true
//        NotificationCenter.default.addObserver(self, selector: #selector(windowOrientationChange), name: NSNotification.Name., object: <#T##Any?#>)
        contentView.layer.cornerRadius = 30
        readMoreButton.layer.cornerRadius = 15
        if let imageUrl = article?.image {
            if let url = URL(string: imageUrl) {
                self.img.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder.png"), options: SDWebImageOptions.init()) { (image, error, cache, url) in
                    self.img.backgroundColor = UIColor(patternImage: (image ?? UIImage(named: "placeholder")!).blurEffect())
                }
                self.img.backgroundColor = UIColor(patternImage: self.img.image!.blurEffect())

            }
        }
    }

    @objc func closeWindow(_ sender: UITapGestureRecognizer) {
        print("close")
//        self.navigationController?.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    @objc func shareArticle(_ sender: UITapGestureRecognizer) {
        if let urlStr = article?.url{
            if let url = NSURL(string: urlStr){
                let activityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
                activityViewController.popoverPresentationController?.sourceView = self.view
                self.present(activityViewController, animated: true, completion: nil)
            }
        }
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

extension PageContentViewController: UIViewControllerTransitioningDelegate {
  func animationController(forPresented presented: UIViewController,
                           presenting: UIViewController,
                           source: UIViewController)
    -> UIViewControllerAnimatedTransitioning? {
    return FlipPresentAnimationController(originFrame: view.frame)
  }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FlipPresentAnimationController(originFrame: view.frame)
    }
}
