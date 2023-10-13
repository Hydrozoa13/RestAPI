//
//  CollectionVC.swift
//  RestAPI
//
//  Created by Евгений Лойко on 6.10.23.
//

import UIKit

final class CollectionVC: UICollectionViewController {
    
    private let reuseIdentifier = "Cell"
    private let userActions = UserActions.allCases

    // MARK: - UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        userActions.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ActionsCVCell
        let userAction = userActions[indexPath.row].rawValue
        cell.infoLbl.text = userAction
        cell.layer.cornerRadius = 20
        cell.layer.borderWidth = 4
        cell.layer.borderColor = #colorLiteral(red: 1, green: 0.5109863281, blue: 0, alpha: 1)
        return cell
    }

    // MARK: - UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userAction = userActions[indexPath.row]
        switch userAction {
            case .downloadImage: performSegue(withIdentifier: "goToImageDetail", sender: nil)
            case .users: performSegue(withIdentifier: "goToUsersList", sender: nil)
        }
    }
}
