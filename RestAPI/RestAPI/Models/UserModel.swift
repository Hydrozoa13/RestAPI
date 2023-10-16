//
//  UserModel.swift
//  RestAPI
//
//  Created by Евгений Лойко on 11.10.23.
//

import Foundation

struct User: Codable {
    let id: Int
    var name: String?
    var username: String?
    var email: String?
    let address: Address?
    var phone: String?
    var website: String?
    let company: Company?
}

struct Address: Codable {
    let street: String?
    let suite: String?
    let city: String?
    let zipcode: String?
    let geo: Geo?
}

struct Geo: Codable {
    let lat: String?
    let lng: String?
}

struct Company: Codable {
    let name: String?
    let catchPhrase: String?
    let bs: String?
}
