//
//  Street.swift
//  FriendsList
//
//  Created by Emre Alpago on 30.09.2024.
//

import Foundation

struct Street: Codable {

    let name: String?
    let number: Int?

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case number = "number"
    }
}
