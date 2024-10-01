//
//  RandomUserManager.swift
//  FriendsList
//
//  Created by Emre Alpago on 30.09.2024.
//

import Foundation

protocol RandomUserManagerInterface {
    var result: RandomUserResponse? { get }

    func fetchRandomUser(completion: @escaping (Result<RandomUserResponse, NetworkError>) -> ())
}

final class RandomUserManager: RandomUserManagerInterface {
    static let shared = RandomUserManager()
    var result: RandomUserResponse?

    func fetchRandomUser(completion: @escaping (Result<RandomUserResponse, NetworkError>) -> ()) {
        NetworkManager.shared.request(requestRoute: NetworkRouter.users, responseModel: RandomUserResponse.self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                print("Received repos: \(response)")
                self.result = response
                completion(.success(response))
            case .failure(let error):
                print("Failed with error: \(error)")
                completion(.failure(error))
            }
        }
    }
}
