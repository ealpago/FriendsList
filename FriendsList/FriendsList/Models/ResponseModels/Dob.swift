//
//  Dob.swift
//  FriendsList
//
//  Created by Emre Alpago on 30.09.2024.
//

import Foundation

struct Dob: Codable {

    let age: Int?
    let date: String?

    enum CodingKeys: String, CodingKey {
        case age = "age"
        case date = "date"
    }
}
