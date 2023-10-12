//
//  UserDetailVC.swift
//  RestAPI
//
//  Created by Евгений Лойко on 12.10.23.
//

import UIKit

class UserDetailVC: UIViewController {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!    
    @IBOutlet weak var websiteLbl: UILabel!
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    private func setupUI() {
        nameLbl.text = user?.name
        usernameLbl.text = user?.username
        emailLbl.text = user?.email
        phoneLbl.text = user?.phone
        websiteLbl.text = user?.website
    }
}
