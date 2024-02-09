//
//  Follower.swift
//  Github Client
//
//  Created by Yamoses on 09/02/2024.
//

import Foundation

struct Follower: Codable, Hashable {
    
      let login: String?
      let id: Int?
      let nodeId: String?
      let avatarUrl: String?
      let gravatarId: String?
      let url: String?
      let htmlUrl: String?
      let followersUrl: String?
      let followingUrl: String?
      let gistsUrl: String?
      let starredUrl: String?
      let subscriptionsUrl: String?
      let organizationsUrl: String?
      let reposUrl: String?
      let eventsUrl: String?
      let receivedEventsUrl: String?
      let type: String?
      let siteAdmin: Bool?
  
  
      // CodingKeys enum to map JSON keys to struct properties
      private enum CodingKeys: String, CodingKey {
          case login, id, nodeId = "node_id", avatarUrl = "avatar_url", gravatarId = "gravatar_id", url, htmlUrl = "html_url", followersUrl = "followers_url", followingUrl = "following_url", gistsUrl = "gists_url", starredUrl = "starred_url", subscriptionsUrl = "subscriptions_url", organizationsUrl = "organizations_url", reposUrl = "repos_url", eventsUrl = "events_url", receivedEventsUrl = "received_events_url", type, siteAdmin
      }
  
      func hash(into hasher: inout Hasher) {
          hasher.combine(login)
      }
  }

struct Repo: Codable, Hashable {
    let id: Int
    let name: String?
    let description: String?
    let language: String?
    let stargazersCount: Int?

}




// Parse JSON data into DetailedGitHubUser
//func parseDetailedGitHubUserJSON() {
//    let jsonData = """
//        {
//          "login": "octocat",
//          "id": 1,
//          "node_id": "MDQ6VXNlcjE=",
//          "avatar_url": "https://github.com/images/error/octocat_happy.gif",
//          // ... (other properties)
//        }
//    """.data(using: .utf8)!
//
//    do {
//        let detailedGitHubUser = try JSONDecoder().decode(Follower.self, from: jsonData)
//        print(detailedGitHubUser)
//    } catch {
//        print("Error decoding JSON: \(error)")
//    }
//}

