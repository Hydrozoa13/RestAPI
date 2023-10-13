//
//  ApiConstants.swift
//  RestAPI
//
//  Created by Евгений Лойко on 11.10.23.
//

import Foundation

struct ApiConstants {
    static let serverPath = "http://localhost:3000/"
    static let usersPath = serverPath + "users"
    static let usersURL = URL(string: usersPath)
}
