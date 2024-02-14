//
//  NetworkManager .swift
//  Github Client
//
//  Created by Yamoses on 09/02/2024.
//

import UIKit

//class NetworkManager {
//    static let shared = NetworkManager()
//    private let baseURL = "https://api.github.com"
//    let cache = NSCache<NSString, UIImage>()
//    
//    public init() {}
//    
//    func getFollowers(username: String, page: Int, completionHandler: @escaping ([Follower]?, String?) -> Void) {
//        let endPoint = baseURL + "/users/\(username)/followers?per_page=100&page=\(page)"
//        
//        guard let url = URL(string: endPoint) else {
//            completionHandler(nil, "Invalid request. Please try again.")
//            return
//        }
//        
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error = error {
//                self.handleNetworkError(error, completionHandler: completionHandler)
//                return
//            }
//            
//            guard let httpResponse = response as? HTTPURLResponse else {
//                self.handleInvalidResponse(completionHandler: completionHandler)
//                return
//            }
//            
//            print("Response status code: \(httpResponse.statusCode)")
//            
//            guard let data = data else {
//                self.handleInvalidData(completionHandler: completionHandler)
//                return
//            }
//            
//            do {
//                let decoder = JSONDecoder()
//                let githubUsers = try decoder.decode([Follower].self, from: data)
//                completionHandler(githubUsers, nil)
//            } catch let decodingError {
//                self.handleJSONDecodingError(decodingError, completionHandler: completionHandler)
//            }
//        }
//        task.resume()
//    }
//    
//    func getUser(username: String, completionHandler: @escaping (User?, String?) -> Void) {
//        let endPoint = baseURL + "/users/\(username)"
//        
//        guard let url = URL(string: endPoint) else {
//            completionHandler(nil, "Invalid request. Please try again.")
//            return
//        }
//        
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error = error {
//                print("Request not completed, check your internet connection:", error)
//                return
//            }
//            
//            guard let httpResponse = response as? HTTPURLResponse else {
//                print("Invalid response, try again")
//                return
//            }
//            
//            print("Response status code: \(httpResponse.statusCode)")
//            
//            guard let data = data else {
//                print("Data received is invalid, try again")
//                return
//            }
//            
//            do {
//                let decoder = JSONDecoder()
//                let githubUsers = try decoder.decode(User.self, from: data)
//                completionHandler(githubUsers, nil)
//            } catch let decodingError {
//                print("Error decoding JSON:", decodingError)
//            }
//        }
//        task.resume()
//    }
//
//    func getRepos(username: String, completionHandler: @escaping ([Repo]?, String?) -> Void) {
//        let endPoint = baseURL + "/users/\(username)/repos"
//
//        guard let url = URL(string: endPoint) else {
//            print("Invalid URL")
//            return
//        }
//
//        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
//            guard let _ = self else { return }
//
//            if let error = error {
//                print("Error fetching repositories: \(error)")
//                return
//            }
//
//            guard let data = data else {
//                print("No data received")
//                return
//            }
//
//            do {
//                let decoder = JSONDecoder()
//                let userRepos = try decoder.decode([Repo].self, from: data)
//                completionHandler(userRepos, nil)
//            } catch let decodingError {
//                print("Error decoding JSON: \(decodingError)")
//            }
//        }.resume()
//    }
//    
//        
//    private func handleNetworkError(_ error: Error, completionHandler: @escaping ([Follower]?, String?) -> Void) {
//        print("Network error: \(error)")
//        completionHandler(nil, "Request not completed, check your internet connection.")
//    }
//    
//    private func handleInvalidResponse(completionHandler: @escaping ([Follower]?, String?) -> Void) {
//        print("Invalid response")
//        completionHandler(nil, "Invalid response, try again.")
//    }
//    
//    private func handleInvalidData(completionHandler: @escaping ([Follower]?, String?) -> Void) {
//        print("Invalid data received")
//        completionHandler(nil, "Data received is invalid, try again.")
//    }
//    
//    private func handleJSONDecodingError(_ decodingError: Error, completionHandler: @escaping ([Follower]?, String?) -> Void) {
//        print("Error decoding JSON: \(decodingError)")
//        completionHandler(nil, "Data received is invalid, try again.")
//    }
//}


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
