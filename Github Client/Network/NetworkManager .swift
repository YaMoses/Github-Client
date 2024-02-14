//
//  NetworkManager .swift
//  Github Client
//
//  Created by Yamoses on 09/02/2024.
//

import UIKit

// MARK: - NetworkService Protocol

protocol NetworkService {
    func fetchData<T: Decodable>(from url: URL, expecting type: T.Type, completionHandler: @escaping (Result<T, NetworkError>) -> Void)
}

enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case invalidData
    case decodingError(Error)
}

// MARK: - URLSession Extension

extension URLSession: NetworkService {
    func fetchData<T: Decodable>(from url: URL, expecting type: T.Type, completionHandler: @escaping (Result<T, NetworkError>) -> Void) {
        dataTask(with: url) { data, response, error in
            if let error = error {
                completionHandler(.failure(.requestFailed(error)))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                completionHandler(.failure(.invalidResponse))
                return
            }

            print("Response status code: \(httpResponse.statusCode)")

            guard let data = data else {
                completionHandler(.failure(.invalidData))
                return
            }

            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completionHandler(.success(decodedData))
            } catch let decodingError {
                completionHandler(.failure(.decodingError(decodingError)))
            }
        }.resume()
    }
}

// MARK: - NetworkManager

class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://api.github.com"
    let cache = NSCache<NSString, UIImage>()

    private init() {}

    func getFollowers(username: String, page: Int, completionHandler: @escaping (Result<[Follower], NetworkError>) -> Void) {
        guard let url = URL(string: "\(baseURL)/users/\(username)/followers?per_page=100&page=\(page)") else {
            completionHandler(.failure(.invalidURL))
            return
        }

        URLSession.shared.fetchData(from: url, expecting: [Follower].self) { result in
            switch result {
            case .success(let followers):
                completionHandler(.success(followers))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getUser(username: String, completionHandler: @escaping (Result<User, NetworkError>) -> Void) {
        guard let url = URL(string: "\(baseURL)/users/\(username)") else {
            completionHandler(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.fetchData(from: url, expecting: User.self) { result in
            switch result {
            case .success(let user):
                completionHandler(.success(user))
            case.failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getRepos(username: String, completionHandler: @escaping (Result<[Repo], NetworkError>) -> Void) {
        guard let url = URL(string: "\(baseURL)/users/\(username)/repos") else {
            completionHandler(.failure(.invalidURL))
            return
        }

        URLSession.shared.fetchData(from: url, expecting: [Repo].self) { result in
            switch result {
            case .success(let repo):
                completionHandler(.success(repo))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }

}
