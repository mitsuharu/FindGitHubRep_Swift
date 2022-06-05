//
//  InAppWebState.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2021/11/25.
//

import Foundation

struct InAppWebItem: Identifiable {
    let id: Int
    let url: String
}

struct InAppWebState {
    let item: InAppWebItem?

    static func initialState() -> InAppWebState {
        InAppWebState(item: nil)
    }
}
