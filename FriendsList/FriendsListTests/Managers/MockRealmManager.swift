//
//  MockRealmManager.swift
//  FriendsListTests
//
//  Created by Emre Alpago on 2.10.2024.
//

@testable import FriendsList

class MockRealmManager: RealmManagerInterface{

    var invokedPerformMigration = false
    var invokedPerformMigrationCount = 0

    func performMigration() {
        invokedPerformMigration = true
        invokedPerformMigrationCount += 1
    }

    var invokedSaveUserToRealm = false
    var invokedSaveUserToRealmCount = 0
    var invokedSaveUserToRealmParameters: (user: ResponseResult, Void)?
    var invokedSaveUserToRealmParametersList = [(user: ResponseResult, Void)]()

    func saveUserToRealm(user: ResponseResult) {
        invokedSaveUserToRealm = true
        invokedSaveUserToRealmCount += 1
        invokedSaveUserToRealmParameters = (user, ())
        invokedSaveUserToRealmParametersList.append((user, ()))
    }

    var invokedFetchUsersFromRealm = false
    var invokedFetchUsersFromRealmCount = 0
    var stubbedFetchUsersFromRealmResult: [CachedUser]! = []

    func fetchUsersFromRealm() -> [CachedUser] {
        invokedFetchUsersFromRealm = true
        invokedFetchUsersFromRealmCount += 1
        return stubbedFetchUsersFromRealmResult
    }

    var invokedRemoveRealmCache = false
    var invokedRemoveRealmCacheCount = 0

    func removeRealmCache() {
        invokedRemoveRealmCache = true
        invokedRemoveRealmCacheCount += 1
    }
}
