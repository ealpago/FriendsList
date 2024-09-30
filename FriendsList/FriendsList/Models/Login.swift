//
//  Login.swift
//  FriendsList
//
//  Created by Emre Alpago on 30.09.2024.
//

import Foundation

struct Login: Codable {

    let md5: String?
    let password: String?
    let salt: String?
    let sha1: String?
    let sha256: String?
    let username: String?
    let uuid: String?

    enum CodingKeys: String, CodingKey {
        case md5 = "md5"
        case password = "password"
        case salt = "salt"
        case sha1 = "sha1"
        case sha256 = "sha256"
        case username = "username"
        case uuid = "uuid"
    }
}
