//
//  Picture.swift
//  FriendsList
//
//  Created by Emre Alpago on 30.09.2024.
//

import Foundation

struct Picture: Codable {

    let large: String?
    let medium: String?
    let thumbnail: String?

    enum CodingKeys: String, CodingKey {
        case large = "large"
        case medium = "medium"
        case thumbnail = "thumbnail"
    }
}
