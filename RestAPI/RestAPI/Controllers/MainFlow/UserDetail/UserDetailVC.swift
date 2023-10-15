//
//  UserDetailVC.swift
//  RestAPI
//
//  Created by Евгений Лойко on 12.10.23.
//

import UIKit
import MapKit

class UserDetailVC: UIViewController {
    
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!    
    @IBOutlet weak var websiteLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var companyLbl: UILabel!
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func openMapAction() { setCoordinatesOnMap() }
    
    @IBAction func openPostsAction() {
        let storyboard = UIStoryboard(name: "PostsFlow", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "PostsListTVC") as? PostsListTVC else { return }
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupUI() {
        navigationItem.title = user?.name
        usernameLbl.text = user?.username
        emailLbl.text = user?.email
        phoneLbl.text = user?.phone
        websiteLbl.text = user?.website
        companyLbl.text = user?.company?.name
        if let city = user?.address?.city,
           let street = user?.address?.street,
           let suite = user?.address?.suite,
           let zipcode = user?.address?.zipcode {
            addressLbl.text = "\(city)\n\(street)\n\(suite)\n\(zipcode)"
        } else {
            addressLbl.text = "Unknown"
        }
    }
    
    private func setCoordinatesOnMap() {
        if let user = user,
           let latitudeString = user.address?.geo?.lat,
           let longitudeString = user.address?.geo?.lng,
           let latitude = Double(latitudeString),
           let longitude = Double(longitudeString) {
            let coordinate = CLLocationCoordinate2D(latitude: latitude,
                                                    longitude: longitude)
            let placemark = MKPlacemark(coordinate: coordinate)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = user.name
            mapItem.openInMaps(launchOptions: nil)
        }
    }
}