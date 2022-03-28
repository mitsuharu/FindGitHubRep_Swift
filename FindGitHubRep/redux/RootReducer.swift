//
//  RootReducer.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2021/11/25.
//

import Foundation
import ReMVVMSwiftUI

struct RootReducer: Reducer {
    static func reduce(state: RootState, with action: StoreAction) -> RootState {

        var nextCounter = state.counter
        if action is CounterAction {
            nextCounter = CounterReducer.reduce(state: state.counter, with: action)
        }

        var nextInAppSafariView = state.inAppSafariView
        if action is InAppSafariViewAction {
            nextInAppSafariView = InAppSafariViewReducer.reduce(state: state.inAppSafariView, with: action)
        }

        var nextToast = state.toast
        if action is ToastAction {
            nextToast = ToastReducer.reduce(state: state.toast, with: action)
        }

        return RootState(
            counter: nextCounter,
            inAppSafariView: nextInAppSafariView,
            toast: nextToast
        )
    }
}
