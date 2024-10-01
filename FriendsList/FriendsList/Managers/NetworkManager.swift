//
//  NetworkManager.swift
//  FriendsList
//
//  Created by Emre Alpago on 30.09.2024.
//

import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

public enum NetworkRouter {
    case users
    
    public var method: HTTPMethod {
        switch self {
        case .users:
            return .get
        }
    }
    
    public var path: String {
        switch self {
        case .users:
            return APIConstants.shared.randomUserBaseURL + "api/?results=20"
        }
    }
}

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case decodingError(Error)
}

final class NetworkManager {
    static let shared = NetworkManager(session: URLSession(configuration: .default))
    private let session: URLSession
    
    private init(session: URLSession) {
        self.session = session
    }
    
    public func request<T: Codable>(requestRoute: NetworkRouter, responseModel: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let url = URL(string: requestRoute.path) else {
            completion(.failure(.invalidURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = requestRoute.method.rawValue
        let task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if error != nil {
                    completion(.failure(.requestFailed))
                    return
                }
                guard let data = data else {
                    completion(.failure(.requestFailed))
                    return
                }
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        task.resume()
    }
}
