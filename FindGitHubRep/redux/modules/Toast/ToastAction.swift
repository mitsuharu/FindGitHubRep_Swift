//
//  ToastActions.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2022/01/28.
//

import Foundation
import ReMVVMSwiftUI

enum ToastAction: StoreAction {
    case enqueueToast(message: String, type: ToastType?)
    case dequeueToast(id: Int)
    case clearToast
}
