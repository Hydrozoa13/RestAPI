//
//  NewUserVC.swift
//  RestAPI
//
//  Created by Евгений Лойко on 16.10.23.
//

import UIKit
import Alamofire
import SwiftyJSON

class NewUserVC: UIViewController {
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var websiteTF: UITextField!
    
    @IBAction func createNewUser() {
        if let name = nameTF.text,
           let username = usernameTF.text,
           let email = emailTF.text,
           let phone = phoneTF.text,
           let website = websiteTF.text {
            
            if let url = ApiConstants.usersURL {
                
                let parameters: Parameters = ["name": name,
                                              "username": username,
                                              "email": email,
                                              "phone": phone,
                                              "website": website]
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
}
