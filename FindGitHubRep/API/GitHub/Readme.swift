//
//  Readme.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2022/03/26.
//

import Foundation

struct Readme: Codable, Identifiable {
    var id: Int
    let name: String
    let downloadUrl: String

    enum CodingKeys: String, CodingKey {
        case id = "size"
        case name
        case downloadUrl = "download_url"
    }
}
