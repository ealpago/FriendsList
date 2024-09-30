//
//  Result.swift
//  FriendsList
//
//  Created by Emre Alpago on 30.09.2024.
//

import Foundation

struct ResponseResult: Codable {

    let cell: String?
    let dob: Dob?
    let email: String?
    let gender: String?
    let id: Id?
    let location: Location?
    let login: Login?
    let name: Name?
    let nat: String?
    let phone: String?
    let picture: Picture?
    let registered: Dob?

    enum CodingKeys: String, CodingKey {
        case cell = "cell"
        case dob
        case email = "email"
        case gender = "gender"
        case id
        case location
        case login
        case name
        case nat = "nat"
        case phone = "phone"
        case picture
        case registered
    }
}
