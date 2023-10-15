//
//  ApiConstants.swift
//  RestAPI
//
//  Created by Евгений Лойко on 11.10.23.
//

import Foundation

struct ApiConstants {
    static let serverPath = "http://localhost:3000/"
    
    private static let usersPath = serverPath + "users"
    static let usersURL = URL(string: usersPath)
    
    static let postsPath = serverPath + "posts"
}
