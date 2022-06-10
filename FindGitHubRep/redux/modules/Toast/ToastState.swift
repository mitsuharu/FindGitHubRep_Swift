//
//  ToastState.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2022/01/28.
//

import Foundation

enum ToastType {
    case info
    case success
    case error
}

struct ToastItem: Identifiable, Equatable {
    let id: Int
    let message: String
    let type: ToastType
}

struct ToastState {
    let items: [ToastItem]

    static func initialState() -> ToastState {
        ToastState(items: [])
    }
}
