//
//  DetailPhotoVC.swift
//  RestAPI
//
//  Created by Евгений Лойко on 19.10.23.
//

import UIKit

class DetailPhotoVC: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var photo: Photo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPhoto()
    }
    
    private func getPhoto() {
        guard let photo,
              let imagePath = photo.url,
              let url = URL(string: imagePath) else { return }
        NetworkService.downloadImage(from: url) { [weak self] image, error in
            DispatchQueue.main.async {
                self?.imageView.image = image
                self?.activityIndicator.stopAnimating()
            }
        }
    }
}
