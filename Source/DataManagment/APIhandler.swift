//
//  APIhandler.swift
//  NewsKit-iOS-App
//
//  Created by Дмитро Лопушанський on 10/4/19.
//  Copyright © 2019 OlehTyzhai. All rights reserved.
//

import Foundation

class APIhandler {
    static let shared = APIhandler()
    private let decoder = JSONDecoder()
    
    func signIn(username: String, password: String, callback: (() -> Void)? = nil){
        let urlString = "http://newskit.pythonanywhere.com/api/signin"
        let url = URL(string: urlString)!
        
        let parameterDictionary = ["username": username, "password": password, "api_key": "SomeSuperSecretApiKeyForiOSNewsKitApplication2019_ODO"]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        request.httpBody = httpBody
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if data != nil {
                if let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                    if let name = json["name"] as? String {
                        User.shared.name = name
                    }
                    if let topics = json["topics"] as? String {
                        User.shared.topics = topics.components(separatedBy: ", ")
                    }
                    if let notificationTime = json["notificationTime"] as? String {
                        User.shared.notificationTime = notificationTime
                    }
                    if let username = json["username"] as? String {
                        User.shared.username = username
                    }
                    if let websites = json["websites"] as? String {
                        User.shared.websites = websites.components(separatedBy: ", ")
                    }
                    if let newsToSend = json["newsToSend"] as? String {
                        User.shared.newsToSendID = newsToSend.components(separatedBy: ", ")
                    }
                }
                
                print("user logged in!", User.shared.username)
                do {
                    let encodedUsername = try generateHash(for: User.shared.username)
                    defaults.set(encodedUsername, forKey: "username")
                     print("username saved")
               } catch {
                   print("Error in user encoding!")
               }
                
            }
            DispatchQueue.main.async {
                NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "userLoggedIn")))
            }
        }
        dataTask.resume()
        NotificationCenter.default.addObserver(self, selector: #selector(userLoggedIn), name: NSNotification.Name(rawValue: "userLoggedIn"), object: nil)
    }
    @objc func userLoggedIn() {
        DispatchQueue.main.async {
            AppCoordinator.shared.presentMainViewController()
            print("presenting main VC")
        }
    }
    
    func signUp(username: String, password: String, fullname: String, callback: (() -> Void)? = nil){
        let urlString = "http://newskit.pythonanywhere.com/api/signup"
        let url = URL(string: urlString)!
        
        
        let parameterDictionary = ["username": username, "password": password, "fullname": fullname, "api_key": "SomeSuperSecretApiKeyForiOSNewsKitApplication2019_ODO"]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        request.httpBody = httpBody
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if data != nil {
                User.shared.username = username
                User.shared.name = fullname
                print("user created!")
                do {
                    let encodedUsername = try generateHash(for: username)
                    defaults.set(encodedUsername, forKey: "username")
                } catch {
                    print("Error in user encoding!")
                }
                
            } else {
                print(response ?? "no response", error ?? "no error", data ?? "no data")
            }
            DispatchQueue.main.async {
                NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "userCreated")))
            }
        }
        dataTask.resume()
        NotificationCenter.default.addObserver(self, selector: #selector(userCreated), name: NSNotification.Name(rawValue: "userCreated"), object: nil)
    }
    @objc func userCreated() {
        DispatchQueue.main.async {
            AppCoordinator.shared.presentMainViewController()
        }
    }
    
    func changeTopics(username: String, topics: String, callback: (() -> Void)? = nil){
        let urlString = "http://newskit.pythonanywhere.com/api/changetopics"
        let url = URL(string: urlString)!
        
        let parameterDictionary = ["username": username, "topics": topics.lowercased(), "api_key": "SomeSuperSecretApiKeyForiOSNewsKitApplication2019_ODO"]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        request.httpBody = httpBody
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if data != nil {
                print("Topics changed!")
            } else {
                print(response ?? "no response", error ?? "no error", data ?? "no data")
            }
        }
        dataTask.resume()
    }
    
}
