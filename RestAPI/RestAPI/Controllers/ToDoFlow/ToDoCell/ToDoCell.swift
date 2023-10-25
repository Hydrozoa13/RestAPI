//
//  ToDoCell.swift
//  RestAPI
//
//  Created by Евгений Лойко on 19.10.23.
//

import UIKit

class ToDoCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var toDoId: Int?

    @IBAction func segmentedCAction(_ sender: UISegmentedControl) {
        let completed: Bool
        switch sender.selectedSegmentIndex {
            case 1: completed = true
            default: completed = false
        }
        NetworkService.patchToDo(completed: completed, toDoId: toDoId ?? 0)
    }
}
