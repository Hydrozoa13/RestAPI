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
            NetworkService.postNewUser(name: name,
                                       username: username,
                                       email: email,
                                       phone: phone,
                                       website: website,
                                       navC: navigationController)
        }
    }
}
