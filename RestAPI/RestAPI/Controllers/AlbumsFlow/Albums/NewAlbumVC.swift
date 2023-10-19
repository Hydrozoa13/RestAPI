//
//  NewAlbumVC.swift
//  RestAPI
//
//  Created by Евгений Лойко on 19.10.23.
//

import UIKit

class NewAlbumVC: UIViewController {

    @IBOutlet weak var titleTF: UITextField!
    
    var userId: Int?
    
    @IBAction func saveNewAlbum() {
        guard let title = titleTF.text else { return }
        NetworkService.postNewAlbum(userId: userId ?? 0,
                                    title: title,
                                    navC: navigationController)
    }
}
