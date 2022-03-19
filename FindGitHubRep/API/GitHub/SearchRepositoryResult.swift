//
//  Repositories.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2021/11/28.
//

import Foundation

struct SearchRepositoryResult: Codable {

    let total: Int
    let items: [Repository]

    enum CodingKeys: String, CodingKey {
        case total = "total_count"
        case items
    }
}
