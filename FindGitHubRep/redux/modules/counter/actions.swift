//
//  actions.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2021/11/25.
//

import Foundation
import ReMVVMSwiftUI

enum CounterAction: StoreAction {
    case increase
    case decrease
    case assign(value: Int)
}
