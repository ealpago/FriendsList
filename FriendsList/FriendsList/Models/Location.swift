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
    let postcode: Postcode?
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

enum Postcode: Codable {
    case int(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let intValue = try? container.decode(Int.self) {
            self = .int(intValue)
        } else if let stringValue = try? container.decode(String.self) {
            self = .string(stringValue)
        } else {
            throw DecodingError.typeMismatch(Postcode.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Expected to decode Int or String for postcode"))
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .int(let value):
            try container.encode(value)
        case .string(let value):
            try container.encode(value)
        }
    }
}
