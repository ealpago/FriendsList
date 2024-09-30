//
//  Info.swift
//  FriendsList
//
//  Created by Emre Alpago on 30.09.2024.
//

import Foundation

struct Info: Codable {

    let page: Int?
    let results: Int?
    let seed: String?
    let version: String?

    enum CodingKeys: String, CodingKey {
        case page = "page"
        case results = "results"
        case seed = "seed"
        case version = "version"
    }
}
