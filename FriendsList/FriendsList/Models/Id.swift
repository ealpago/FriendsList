//
//  Id.swift
//  FriendsList
//
//  Created by Emre Alpago on 30.09.2024.
//

import Foundation

struct Id: Codable {

    let name: String?
    let value: String?

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case value = "value"
    }
}
