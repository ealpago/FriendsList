//
//  MockRandomUserManager.swift
//  FriendsListTests
//
//  Created by Emre Alpago on 1.10.2024.
//

@testable import FriendsList

final class MockRandomUserManager: RandomUserManagerInterface {
    var stubbedResponse: FriendsList.RandomUserResponse?
    var stubbedResult: Result<FriendsList.RandomUserResponse, FriendsList.NetworkError>?

    var invokeFetchRandomUser: Bool = false
    var invokeFetchRandomUserCount: Int = 0

    func fetchRandomUser(completion: @escaping (Result<FriendsList.RandomUserResponse, FriendsList.NetworkError>) -> ()) {
        invokeFetchRandomUser = true
        invokeFetchRandomUserCount += 1
        if let result = stubbedResponse {
            completion(.success(result))
        } else {
            completion(.failure(.requestFailed))
        }
    }
}
