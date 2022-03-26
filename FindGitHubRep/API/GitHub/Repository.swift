//
//  Repositoriy.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2021/11/28.
//

import Foundation

struct Repository: Codable, Identifiable {

    let id: Int
    let name: String
    let fullName: String
    let url: String
    let description: String?
    let owner: User
    let stars: Int
    let watchers: Int
    let topics: [String]
    let defaultBranch: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case fullName = "full_name"
        case url = "html_url"
        case description
        case owner
        case stars = "stargazers_count"
        case watchers = "watchers_count"
        case topics
        case defaultBranch = "default_branch"
    }
}
