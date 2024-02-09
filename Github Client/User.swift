//
//  User.swift
//  Github Client
//
//  Created by Yamoses on 09/02/2024.
//

import Foundation

struct User: Codable, Hashable {
    
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
    let name: String?
    let company: String?
    let blog: String?
    let location: String?
    let email: String?
    let hireable: Bool?
    let bio: String?
    let twitterUsername: String?
    let publicRepos: Int?
    let publicGists: Int?
    let followers: Int?
    let following: Int?
    let createdAt: String?
    let updatedAt: String?
    
    // CodingKeys enum to map JSON keys to struct properties
    private enum CodingKeys: String, CodingKey {
            case login, id, nodeId = "node_id", avatarUrl = "avatar_url", gravatarId = "gravatar_id", url, htmlUrl = "html_url", followersUrl = "followers_url", followingUrl = "following_url", gistsUrl = "gists_url", starredUrl = "starred_url", subscriptionsUrl = "subscriptions_url", organizationsUrl = "organizations_url", reposUrl = "repos_url", eventsUrl = "events_url", receivedEventsUrl = "received_events_url", type, siteAdmin, name, company, blog, location, email, hireable, bio, twitterUsername, publicRepos, publicGists, followers, following, createdAt, updatedAt
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(login)
    }

    struct RepoURLClass: Codable, Hashable {
        let type, format: String
        let examples: [String]
    }
}

