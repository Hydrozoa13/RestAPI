//
//  ToDoModel.swift
//  RestAPI
//
//  Created by Евгений Лойко on 19.10.23.
//

import Foundation

struct ToDo: Codable {
    let userId: Int
    let id: Int
    let title: String?
    let completed: Bool
}
