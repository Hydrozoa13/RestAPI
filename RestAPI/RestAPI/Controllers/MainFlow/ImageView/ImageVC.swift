//
//  ImageVC.swift
//  RestAPI
//
//  Created by Евгений Лойко on 6.10.23.
//

import UIKit

final class ImageVC: UIViewController {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    
    private let randomImage = ImagesURL().imagesArray.randomElement()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImage()
    }
    
    private func fetchImage() {
        guard let imageURL = randomImage,
              let url = URL(string: imageURL) else { return }
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
                
                if let image = CacheService.shared.imageCache.image(withIdentifier: imageURL) {
                    self?.imageView.image = image
                    return
                } else if let data = data,
                   let image = UIImage(data: data) {
                    CacheService.shared.imageCache.add(image, withIdentifier: imageURL)
                    self?.imageView.image = image
                } else {
                    let errorImage = UIImage(named: "error404")
                    self?.imageView.image = errorImage
                }
            }
        }.resume()
    }
}
