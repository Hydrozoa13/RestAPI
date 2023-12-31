//
//  CommentModel.swift
//  RestAPI
//
//  Created by Евгений Лойко on 19.10.23.
//

import Foundation

struct Comment: Codable {
    let postId: Int
    let id: Int
    let name: String?
    let email: String?
    let body: String?
}
