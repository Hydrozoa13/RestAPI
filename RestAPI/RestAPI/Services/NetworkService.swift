//
//  NetworkService.swift
//  RestAPI
//
//  Created by Евгений Лойко on 16.10.23.
//

import Alamofire
import SwiftyJSON
import UIKit

class NetworkService {
    
    static func postURLSession(for user: User?, title: String?, body: String?, navC: UINavigationController?) {
           if let userId = user?.id,
           let title = title,
           let body = body,
           let url = ApiConstants.postsURL {
            
            var request = URLRequest(url: url)
            
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let postBodyJSON: [String:Any] = ["userId": userId,
                                              "title": title,
                                              "body": body]
            let httpBody = try? JSONSerialization.data(withJSONObject: postBodyJSON)
            request.httpBody = httpBody
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                print(response as Any)
                if let data = data {
                    let json = JSON(data)
                    print(json)
                }
                
                if let error = error {
                    print(error)
                }
                
                DispatchQueue.main.async {
                    navC?.popViewController(animated: true)
                }
            }.resume()
        }
    }
    
    static func postAlamofire(for user: User?, title: String?, body: String?, navC: UINavigationController?) {
        if let userId = user?.id,
           let title = title,
           let body = body,
           let url = ApiConstants.postsURL {
            
            let parameters: Parameters = ["userId": userId,
                                          "title": title,
                                          "body": body]
            AF.request(url, method: .post,
                       parameters: parameters,
                       encoding: JSONEncoding.default)
            .response { response in
                debugPrint(response)
                print(response.request as Any)
                print(response.response as Any)
                debugPrint(response.result)
                
                switch response.result {
                case .success(let data):
                    print(JSON(data as Any))
                    navC?.popViewController(animated: true)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    static func deletePost(postId: Int, callback: @escaping () -> ()) {
        let urlPath = "\(ApiConstants.postsPath)/\(postId)"
        AF.request(urlPath, method: .delete, encoding: JSONEncoding.default)
        .response { response in callback() }
    }
    
    static func postNewUser(name: String,
                            username: String,
                            email: String,
                            phone: String,
                            website: String,
                            navC: UINavigationController?) {
        if let url = ApiConstants.usersURL {
            
            let parameters: Parameters = ["name": name,
                                          "username": username,
                                          "email": email,
                                          "phone": phone,
                                          "website": website]
            AF.request(url, method: .post,
                       parameters: parameters,
                       encoding: JSONEncoding.default)
            .response { response in
                debugPrint(response)
                print(response.request as Any)
                print(response.response as Any)
                debugPrint(response.result)
                
                switch response.result {
                case .success(let data):
                    print(JSON(data as Any))
                    navC?.popViewController(animated: true)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    static func deleteUser(userId: Int, callback: @escaping () -> ()) {
        let urlPath = "\(ApiConstants.usersPath)/\(userId)"
        AF.request(urlPath, method: .delete, encoding: JSONEncoding.default)
        .response { response in callback() }
    }
    
    static func postNewComment(postId: Int,
                               email: String,
                               title: String,
                               body: String,
                               navC: UINavigationController?) {
        if let url = ApiConstants.commentsURL {
            
            let parameters: Parameters = ["postId": postId,
                                          "email": email,
                                          "name": title,
                                          "body": body]
            AF.request(url, method: .post,
                       parameters: parameters,
                       encoding: JSONEncoding.default)
            .response { response in
                debugPrint(response)
                print(response.request as Any)
                print(response.response as Any)
                debugPrint(response.result)
                
                switch response.result {
                case .success(let data):
                    print(JSON(data as Any))
                    navC?.popViewController(animated: true)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    static func deleteComment(commentId: Int, callback: @escaping () -> ()) {
        let urlPath = "\(ApiConstants.commentsPath)/\(commentId)"
        AF.request(urlPath, method: .delete, encoding: JSONEncoding.default)
        .response { response in callback() }
    }
    
    static func postNewToDo(userId: Int,
                            title: String,
                            navC: UINavigationController?) {
        if let url = ApiConstants.toDosURL {
            
            let parameters: Parameters = ["userId": userId,
                                          "title": title,
                                          "completed": false]
            AF.request(url, method: .post,
                       parameters: parameters,
                       encoding: JSONEncoding.default)
            .response { response in
                debugPrint(response)
                print(response.request as Any)
                print(response.response as Any)
                debugPrint(response.result)
                
                switch response.result {
                case .success(let data):
                    print(JSON(data as Any))
                    navC?.popViewController(animated: true)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    static func deleteToDo(toDoId: Int, callback: @escaping () -> ()) {
        let urlPath = "\(ApiConstants.toDosPath)/\(toDoId)"
        AF.request(urlPath, method: .delete, encoding: JSONEncoding.default)
        .response { response in callback() }
    }
    
    static func getThumbnail(thumbnailUrl: String,
                             callback: @escaping (_ result: UIImage?,
                                                  _ error: AFError?) -> ()) {
        AF.request(thumbnailUrl).responseImage { response in
            switch response.result {
                case .success(let image): callback (image, nil)
                case .failure(let error): callback (nil, error)
            }
        }
    }
}
