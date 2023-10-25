//
//  PhotosCVCExt.swift
//  RestAPI
//
//  Created by Евгений Лойко on 24.10.23.
//

import UIKit

extension PhotosCVCell: UIContextMenuInteractionDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            let delete = UIAction(title: "Delete",
                                  image: UIImage(systemName: "trash.slash"),
                                  attributes: .destructive) { _ in
                print("Delete tapped")
            }
            return UIMenu(title: "Context Menu", children: [delete])
        }
    }
}
