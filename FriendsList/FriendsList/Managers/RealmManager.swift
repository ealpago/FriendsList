//
//  RealmManager.swift
//  FriendsList
//
//  Created by Emre Alpago on 1.10.2024.
//

import RealmSwift

class RealmManager {
    static let shared = RealmManager()

    init() {
        performMigration()
    }

    private func performMigration() {
        let config = Realm.Configuration(
            schemaVersion: 1, // Increment this number whenever you change the schema
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 1 {
                    // Migration logic, if needed
                    migration.enumerateObjects(ofType: CachedUser.className()) { oldObject, newObject in
                        // Initialize the new 'id' property with default values or migrate existing data
                        newObject!["id"] = UUID().uuidString
                    }
                }
            }
        )
        Realm.Configuration.defaultConfiguration = config
    }

    func saveUserToRealm(user: ResponseResult) {
        do {
            let realm = try Realm()
            let cachedUser = CachedUser()
            cachedUser.id = user.id?.value ?? UUID().uuidString
            cachedUser.name = user.name?.first ?? ""
            cachedUser.surname = user.name?.last ?? ""
            cachedUser.nationality = user.nat ?? ""
            cachedUser.imageURL = user.picture?.thumbnail ?? ""
            try realm.write {
                realm.add(cachedUser, update: .modified)
            }
        } catch {
            print("Error while saving realm object: \(error)")
        }
    }

    func fetchUsersFromRealm() -> [CachedUser] {
        do {
            let realm = try Realm()
            let users = realm.objects(CachedUser.self)
            print("Fetched Users: \(users)")
            return Array(users)
        } catch {
            print("Error fetching users from Realm: \(error)")
            return []
        }
    }}

