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
        setupUI()
    }
    
    @IBAction func postURLSession() {
        NetworkService.postURLSession(for: user,
                                      title: titleTF.text,
                                      body: bodyTV.text,
                                      navC: navigationController)
    }
    
    @IBAction func postAlamofire() {
        NetworkService.postAlamofire(for: user,
                                     title: titleTF.text,
                                     body: bodyTV.text,
                                     navC: navigationController)
    }
    
    private func setupUI() {
        navigationItem.title = "New Post"
        bodyTV.layer.cornerRadius = 15
    }
}
