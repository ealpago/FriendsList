//
//  RandomUserResponse.swift
//  FriendsList
//
//  Created by Emre Alpago on 30.09.2024.
//

import Foundation

struct RandomUserResponse: Codable {

    let info: Info?
    let results: [ResponseResult]?

    enum CodingKeys: String, CodingKey {
        case info
        case results = "results"
    }
}
