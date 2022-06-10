//
//  AppState.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2021/11/25.
//

import Foundation

struct AppState {
    let toast: ToastState
    let inAppWeb: InAppWebState

    static func initialState() -> AppState {
        AppState(
            toast: ToastState.initialState(),
            inAppWeb: InAppWebState.initialState()
        )
    }
}
