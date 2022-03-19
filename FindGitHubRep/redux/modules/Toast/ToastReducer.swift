//
//  ToastReducer.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2022/01/28.
//

import Foundation
import ReMVVMSwiftUI

enum ToastReducer: Reducer {
    static func reduce(state: ToastState,
                       with action: ToastAction) -> ToastState {
        switch action {
        case .enqueueToast(message: let message, type: let type):
            let id: Int = Int(Date().timeIntervalSince1970)
            let item = ToastItem(id: id, message: message, type: type ?? .info)
            return ToastState(items: state.items + [item])

        case .dequeueToast(id: let id):
            let next = state.items.filter { $0.id != id }
            return ToastState(items: next)

        case .clearToast:
            return ToastState(items: [])
        }
    }
}
