//
//  AppReducer.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2021/11/25.
//

import Foundation
import ReSwift

func appReducer(action: Action, state: AppState?) -> AppState {

    let state = state ?? AppState.initialState()

    var nextToast = state.toast
    if action is ToastActions {
        nextToast = toastReducer(action: action as! ToastActions, state: state.toast)
    }

    var nextinAppWeb = state.inAppWeb
    if action is InAppWebActions {
        nextinAppWeb = InAppReducers(action: action as! InAppWebActions, state: state.inAppWeb)
    }

    return AppState(
        toast: nextToast,
        inAppWeb: nextinAppWeb
    )
}
