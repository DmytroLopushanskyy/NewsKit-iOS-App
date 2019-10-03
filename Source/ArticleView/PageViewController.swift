//
//  PageViewController.swift
//  NewsKit
//
//  Created by Олег on 01.10.2019.
//  Copyright © 2019 OlehTyzhai. All rights reserved.
//

import UIKit

class PageViewController: UIViewController, UIPageViewControllerDataSource {
    var newsList: [Article] = []
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
        return generateContentViewController(index: index)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
//
//        let dataManager = DataManager()
//        dataManager.uploadDataFromAPI(userID: 138918380)
//        do {
//          newsList = try context.fetch(Artticle.fetchRequest())
//        } catch let error as NSError {
//          print("Could not fetch. \(error), \(error.userInfo)")
//        }
//        print(newsList)

        let vc = generateContentViewController(index: 0)
        pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageController.dataSource = self

        addChild(pageController)
        view.addSubview(pageController.view)
        self.pageController.setViewControllers([vc], direction: .forward, animated: true, completion: nil)

        // Do any additional setup after loading the view.
    }

    func generateContentViewController(index: Int) -> PageContentViewController {

        let viewC = storyboard?.instantiateViewController(withIdentifier: "PageContent") as! PageContentViewController
        viewC.index = index
        viewC.article = newsList[index]

        return viewC
    }

    func loadData() {
        let group = DispatchGroup()
        group.enter()
        let news = News()
        news.load(url: URL(string: "http://newskit.pythonanywhere.com/api/getlastnews?user=138918380")!) { (result, _) in
            self.newsList = result
            group.leave()
        }
        group.wait()
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
