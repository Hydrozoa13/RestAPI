//
//  PostModel.swift
//  RestAPI
//
//  Created by Евгений Лойко on 15.10.23.
//

import Foundation

struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String?
    let body: String?
}
