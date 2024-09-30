//
//  RealmManager.swift
//  FriendsList
//
//  Created by Emre Alpago on 1.10.2024.
//

import RealmSwift

class RealmManager {
    static let shared = RealmManager()

    func saveUserToRealm(user: CachedUser) {
        do {
            let realm = try Realm()
            let cachedUser = CachedUser()
            cachedUser.name = user.name
            cachedUser.surname = user.surname  // Changed to surname from name
            cachedUser.nationality = user.nationality
            try realm.write {
                realm.add(cachedUser, update: .modified)
            }
        } catch {
            print("Error while saving realm object: \(error)")
        }
    }
}

