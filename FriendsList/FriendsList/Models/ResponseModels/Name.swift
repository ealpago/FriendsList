//
//  Name.swift
//  FriendsList
//
//  Created by Emre Alpago on 30.09.2024.
//

import Foundation

struct Name: Codable {

    let first: String?
    let last: String?
    let title: String?

    enum CodingKeys: String, CodingKey {
        case first = "first"
        case last = "last"
        case title = "title"
    }
}
