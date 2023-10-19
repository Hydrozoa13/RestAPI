//
//  PhotosCVCell.swift
//  RestAPI
//
//  Created by Евгений Лойко on 19.10.23.
//

import UIKit
import Alamofire
import AlamofireImage

class PhotosCVCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var thumbnailUrl: String? {
        didSet {
            getThumbnailUrl()
        }
    }
    
    private func getThumbnailUrl() {
        guard let thumbnailUrl = thumbnailUrl else { return }
        NetworkService.getThumbnail(thumbnailUrl: thumbnailUrl) { [weak self] image, error in
            self?.activityIndicator.stopAnimating()
            self?.imageView.image = image
        }
    }
}
