//
//  CachedUser.swift
//  FriendsList
//
//  Created by Emre Alpago on 1.10.2024.
//

import RealmSwift

class CachedUser: Object {
    @Persisted var name: String = ""
    @Persisted var surname: String = ""
    @Persisted var nationality: String? = ""
}
