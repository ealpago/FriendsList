//
//  Location.swift
//  FriendsList
//
//  Created by Emre Alpago on 30.09.2024.
//

import Foundation

struct Location: Codable {

    let city: String?
    let coordinates: Coordinate?
    let country: String?
    let postcode: Int?
    let state: String?
    let street: Street?
    let timezone: Timezone?

    enum CodingKeys: String, CodingKey {
        case city = "city"
        case coordinates
        case country = "country"
        case postcode = "postcode"
        case state = "state"
        case street
        case timezone
    }
}
