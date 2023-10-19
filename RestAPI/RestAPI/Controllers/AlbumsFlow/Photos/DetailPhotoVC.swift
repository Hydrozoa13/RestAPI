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
        fetchPhoto()
    }
    
    private func fetchPhoto() {
        guard let photoURL = photo?.url,
                let url = URL(string: photoURL) else { return }
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, error in

            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                if let response = response {
                    print(response)
                }
                if let data = data,
                   let image = UIImage(data: data) {
                    self?.imageView.image = image
                } else {
                    let errorImage = UIImage(named: "error404")
                    self?.imageView.image = errorImage
                }
            }
        }.resume()
    }
}
