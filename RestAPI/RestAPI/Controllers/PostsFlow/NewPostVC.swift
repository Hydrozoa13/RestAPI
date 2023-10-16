//
//  NewPostVC.swift
//  RestAPI
//
//  Created by Евгений Лойко on 16.10.23.
//

import UIKit
import SwiftyJSON
import Alamofire

class NewPostVC: UIViewController {
    
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var bodyTV: UITextView!
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTF.layer.cornerRadius = 25
    }
    
    @IBAction func postURLSession() {
        if let userId = user?.id,
           let title = titleTF.text,
           let body = bodyTV.text,
           let url = ApiConstants.postsURL {
            
            var request = URLRequest(url: url)
            
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let postBodyJSON: [String:Any] = ["userId": userId,
                                              "title": title,
                                              "body": body]
            let httpBody = try? JSONSerialization.data(withJSONObject: postBodyJSON)
            request.httpBody = httpBody
            
            URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                print(response as Any)
                if let data = data {
                    let json = JSON(data)
                    print(json)
                }
                
                if let error = error {
                    print(error)
                }
                
                DispatchQueue.main.async {
                    self?.navigationController?.popViewController(animated: true)
                }
            }.resume()
        }
    }
    
    @IBAction func postAlamofire() {
        if let userId = user?.id,
           let title = titleTF.text,
           let body = bodyTV.text,
           let url = ApiConstants.postsURL {
            
            let parameters: Parameters = ["userId": userId,
                                          "title": title,
                                          "body": body]
            AF.request(url, method: .post,
                       parameters: parameters,
                       encoding: JSONEncoding.default)
            .response { [weak self] response in
                debugPrint(response)
                print(response.request as Any)
                print(response.response as Any)
                debugPrint(response.result)
                
                switch response.result {
                case .success(let data):
                    print(JSON(data as Any))
                    self?.navigationController?.popViewController(animated: true)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
