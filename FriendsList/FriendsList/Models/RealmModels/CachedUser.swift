//
//  CachedUser.swift
//  FriendsList
//
//  Created by Emre Alpago on 1.10.2024.
//

import RealmSwift

class CachedUser: Object {
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var name: String = ""
    @Persisted var surname: String = ""
    @Persisted var nationality: String? = ""
    @Persisted var imageURL: String = ""
}
