//
//  actions.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2021/11/25.
//

import Foundation
import ReMVVMSwiftUI

enum InAppSafariViewAction: StoreAction {
    case show(url: String)
    case dismiss
}
