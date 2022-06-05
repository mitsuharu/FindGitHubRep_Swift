//
//  ToastActions.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2022/01/28.
//

import Foundation
import ReSwift

enum ToastActions: Action {
    case enqueueToast(message: String, type: ToastType? = ToastType.info)
    case dequeueToast(id: Int)
    case clearToast
}
