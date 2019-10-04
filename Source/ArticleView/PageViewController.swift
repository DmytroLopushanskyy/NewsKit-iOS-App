//
//  PageViewController.swift
//  NewsKit
//
//  Created by Олег on 01.10.2019.
//  Copyright © 2019 OlehTyzhai. All rights reserved.
//

import UIKit

class PageViewController: UIViewController, UIPageViewControllerDataSource {
    var newsList: [ArticleData] = []
    var pageController: UIPageViewController!
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let index = (viewController as! PageContentViewController).index - 1
        if index < 0 {
            return nil
        }
        return generateContentViewController(index: index)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let index = (viewController as! PageContentViewController).index + 1
        if index > newsList.count{
            return nil
        }
        return generateContentViewController(index: index)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.loadData()

        Repository.shared.getNews()
        NotificationCenter.default.addObserver(self, selector: #selector(dataLoaded), name: NSNotification.Name(rawValue: "synced"), object: nil)
        self.pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.pageController.dataSource = self
        addChild(pageController)
        view.addSubview(pageController.view)


        // Do any additional setup after loading the view.
    }
    @objc func dataLoaded() {
        DispatchQueue.main.async {
            self.newsList = NewsStorage.shared.news
            let vc = self.generateContentViewController(index: 0)
            self.pageController.setViewControllers([vc], direction: .forward, animated: true, completion: nil)
        }

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    func generateContentViewController(index: Int) -> PageContentViewController {

        let viewC = storyboard?.instantiateViewController(withIdentifier: "PageContent") as! PageContentViewController
        viewC.index = index
        viewC.article = newsList[index]

        return viewC
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
