//
//  Timezone.swift
//  FriendsList
//
//  Created by Emre Alpago on 30.09.2024.
//

import Foundation

struct Timezone: Codable {

    let descriptionField: String?
    let offset: String?

    enum CodingKeys: String, CodingKey {
        case descriptionField = "description"
        case offset = "offset"
    }
}
