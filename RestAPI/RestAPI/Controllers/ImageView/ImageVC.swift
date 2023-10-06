//
//  ImageVC.swift
//  RestAPI
//
//  Created by Евгений Лойко on 6.10.23.
//

import UIKit

class ImageVC: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    private let imageURL = "https://i.artfile.ru/2880x1800_910841_[www.ArtFile.ru].jpg"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImage()
    }
    
    private func fetchImage() {
        guard let url = URL(string: imageURL) else { return }
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, error in

            DispatchQueue.main.async {
                self?.activityIndicatorView.stopAnimating()
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
                } else { print("Error") }
            }
        }.resume()
    }
}
