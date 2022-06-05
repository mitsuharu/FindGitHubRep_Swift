//
//  actions.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2021/11/25.
//

import Foundation
import ReSwift

enum InAppWebActions: Action {
    case show(url: String)
    case clear
}
