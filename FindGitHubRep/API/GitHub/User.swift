//
//  User.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2021/12/15.
//

import Foundation

struct User: Codable {

    let id: Int
    let name: String
    let avatarUrl: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case id
        case name = "login"
        case avatarUrl = "avatar_url"
        case url = "html_url"
    }
}
