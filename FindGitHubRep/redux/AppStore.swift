//
//  AppStore.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2021/11/25.
//

import Foundation
import ReSwift

func makeAppStore() -> Store<AppState> {

    let store = Store<AppState>(
        reducer: appReducer,
        state: AppState.initialState()
    )

    return store
}
