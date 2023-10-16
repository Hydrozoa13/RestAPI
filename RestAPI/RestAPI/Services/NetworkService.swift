//
//  NetworkService.swift
//  RestAPI
//
//  Created by Евгений Лойко on 16.10.23.
//

import Foundation
import Alamofire

class NetworkService {
    
    static func deletePost(postId: Int, callback: @escaping () -> ()) {
        let urlPath = "\(ApiConstants.postsPath)/\(postId)"
        AF.request(urlPath, method: .delete, encoding: JSONEncoding.default)
        .response { response in callback() }
    }
}
