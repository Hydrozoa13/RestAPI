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
    
    static let postsPath = serverPath + "posts"
    static let postsURL = URL(string: postsPath)
    
    static let commentsPath = serverPath + "comments"
    static let commentsURL = URL(string: commentsPath)
    
    static let albumsPath = serverPath + "albums"
    static let albumsURL = URL(string: albumsPath)
    
    static let photosPath = serverPath + "photos"
    static let photosURL = URL(string: photosPath)
    
    static let toDosPath = serverPath + "todos"
    static let toDosURL = URL(string: toDosPath)
}
