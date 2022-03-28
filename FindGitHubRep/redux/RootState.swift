//
//  RootState.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2021/11/25.
//

import Foundation
import ReMVVMSwiftUI

struct RootState: StoreState {
    let counter: CounterState
    let inAppSafariView: InAppSafariViewState
    let toast: ToastState

    static func initialState() -> RootState {
        RootState(
            counter: CounterState.initialState(),
            inAppSafariView: InAppSafariViewState.initialState(),
            toast: ToastState.initialState()
        )
    }
}
