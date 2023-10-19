//
//  NewCommentVC.swift
//  RestAPI
//
//  Created by Евгений Лойко on 19.10.23.
//

import UIKit

class NewCommentVC: UIViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var titleTF: UITextField!    
    @IBOutlet weak var bodyTV: UITextView!

    var postId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bodyTV.layer.cornerRadius = 15
    }
    
    @IBAction func saveComment() {
        if let postId = postId,
           let email = emailTF.text,
           let title = titleTF.text,
           let body = bodyTV.text {
            NetworkService.postNewComment(postId: postId, email: email, title: title, body: body, navC: navigationController)
        }
    }
}
