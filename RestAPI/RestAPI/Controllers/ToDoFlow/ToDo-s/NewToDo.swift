//
//  NewToDo.swift
//  RestAPI
//
//  Created by Евгений Лойко on 19.10.23.
//

import UIKit

class NewToDo: UIViewController {
    
    @IBOutlet weak var toDoTF: UITextField!    
    
    var userId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveToDo() {
        if let userId = userId,
           let title = toDoTF.text {
            NetworkService.postNewToDo(userId: userId,
                                       title: title,
                                       navC: navigationController)
        }
    }
}
