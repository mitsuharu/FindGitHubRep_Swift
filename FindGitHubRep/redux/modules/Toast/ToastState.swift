//
//  ToastState.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2022/01/28.
//

import Foundation
import ReMVVMSwiftUI

enum ToastType {
    case info
    case success
    case error
}

struct ToastItem: Identifiable {
    let id: Int
    let message: String
    let type: ToastType
}

struct ToastState: StoreState {
    let items: [ToastItem]
    static func initialState() -> ToastState{
        return ToastState(items: [])
    }
}
